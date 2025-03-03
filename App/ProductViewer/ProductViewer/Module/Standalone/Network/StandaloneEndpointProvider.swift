//
//  StandaloneEndpointProvider.swift
//  ProductViewer
//
//  Created by Thejus G on 01/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import Foundation

// MARK: - StandaloneEndpointProvider
/// An enum that defines API endpoints for fetching deal-related data.
/// This conforms to `EndpointProvider` to provide base URL and path construction.
enum StandaloneEndpointProvider: EndpointProvider {
    /// Fetches the list of available deals.
    case fetchDeals
    
    /// Fetches details of a specific deal using a product ID.
    case fetchDealsDetails(productId: Int)
    
    // MARK: - Base URL
    
    /// Retrieves the base URL for the product viewer service.
    /// Uses a utility method to handle fetching the URL safely.
    var baseURL: URL? {
        return try? Utility.getProductViewerServiceBaseURL()
    }
    
    // MARK: - Path
    
    /// Constructs the endpoint path based on the API case.
    var path: String {
        switch self {
        case .fetchDeals:
            return "mobile_case_study_deals/v1/deals" // Endpoint for fetching all deals
        case .fetchDealsDetails(let productId):
            return "mobile_case_study_deals/v1/deals/\(productId)" // Endpoint for fetching a specific deal
        }
    }
}
