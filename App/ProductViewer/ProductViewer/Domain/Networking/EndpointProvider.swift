//
//  EndpointProvider.swift
//  ProductViewer
//
//  Created by Thejus G on 01/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import Foundation

public protocol EndpointProvider {
    var baseURL: URL? { get }
    var path: String { get }
}

/// Extension to provide default implementations for `EndpointProvider`.
extension EndpointProvider {
    /// Generates a `URLRequest` using the endpoint properties.
    /// - Throws: `URLError.badURL` if the base URL is missing or invalid.
    /// - Returns: A configured `URLRequest` ready for execution.
    func createRequest() throws -> URLRequest {
        /// Construct the full URL with path
        guard let url = baseURL?.appendingPathComponent(path) else {
            throw URLError(.badURL)
        }
        let request = URLRequest(url: url)
        return request
    }
}

