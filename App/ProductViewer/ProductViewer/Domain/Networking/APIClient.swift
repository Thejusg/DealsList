//
//  APIClient.swift
//  ProductViewer
//
//  Created by Thejus G on 01/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import Foundation
import Combine

/// Protocol defining a generic API request interface
public protocol APIRequesting {
    func perfomRequest<T>(endPoint: EndpointProvider, responseModel: T.Type) -> AnyPublisher<T, Error> where T: Decodable
}

/// A concrete implementation of `APIRequesting` that interacts with a network service.
public final class APIClient: APIRequesting {
    private let urlSession: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    /// Performs an API request and returns a publisher with the decoded response.
    /// - Parameters:
    ///   - endPoint: An object conforming to `EndpointProvider` that generates the request.
    ///   - responseModel: The expected response model type.
    /// - Returns: A publisher emitting either the successfully decoded model or an error.
    public func perfomRequest<T>(endPoint: any EndpointProvider, responseModel: T.Type) -> AnyPublisher<T, any Error> where T : Decodable {
        do {
            let request = try endPoint.createRequest()
            return urlSession
                .dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: T.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
