//
//  MockAPIClient.swift
//  ProductViewerTests
//
//  Created by Thejus G on 02/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import Combine
import XCTest
@testable import ProductViewer

final class MockAPIClient: APIRequesting {
    var shouldReturnError = false
    var mockResponse: Data?
    var mockError: Error?
    
    func perfomRequest<T>(endPoint: any EndpointProvider, responseModel: T.Type) -> AnyPublisher<T, any Error> where T : Decodable {
        if shouldReturnError { return Fail(error: NSError(domain: "", code: -1, userInfo: nil))
            .eraseToAnyPublisher() }
        if let mockError {  return Fail(error: mockError).eraseToAnyPublisher() }
        if let mockResponse {
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: mockResponse)
                return Just(decodedResponse)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } catch {
                return Fail(error: error).eraseToAnyPublisher()
            }
        }
        return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
    }
}


