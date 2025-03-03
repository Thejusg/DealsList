//
//  StandaloneDetailsViewModel.swift
//  ProductViewer
//
//  Created by Thejus G on 01/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import Combine

/// Represents different states of the product details screen.
enum StandaloneDetailsViewModelState {
    case loading
    case loaded(Product)
    case error(Error)
    
    var product: Product? {
        switch self {
        case .loaded(let product):
            return product
        case .loading, .error:
            return nil
        }
    }
}

/// ViewModel responsible for fetching and managing product details.
final class StandaloneDetailsViewModel {
    // MARK: - Properties
    
    /// API Client for network requests (dependency-injected for testability).
    private let apiClient: APIRequesting
    private(set) var product: Product
    
    /// Stores Combine subscriptions to avoid memory leaks.
    var cancellables = Set<AnyCancellable>()
    
    /// Closure to notify the ViewController of state updates.
    var updatedState: (() -> Void)?
    
    var state: StandaloneDetailsViewModelState = .loading {
        didSet {
            updatedState?() // Notify UI when state changes.
        }
    }
    
    // MARK: - Initializer
    
    /// Initializes the ViewModel with a product and optional API client.
    /// - Parameters:
    ///   - product: The initial product to display (used for fallback).
    ///   - apiClient: API client for network requests (default: `APIClient`).
    init(product: Product, apiClient: APIRequesting = APIClient()) {
        self.apiClient = apiClient
        self.product = product
    }
    
    // MARK: - Fetching Product Details
    
    /// Fetches updated product details from the API.
    func fetchProductDetails() {
        self.state = .loading
        let endPoint = StandaloneEndpointProvider.fetchDealsDetails(productId: product.id)
        self.apiClient.perfomRequest(endPoint: endPoint, responseModel: Product.self)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.state = .error(error)
                }
            }, receiveValue: { (detailedProduct) in
                self.state = .loaded(detailedProduct)
            })
            .store(in: &self.cancellables)
    }
}
