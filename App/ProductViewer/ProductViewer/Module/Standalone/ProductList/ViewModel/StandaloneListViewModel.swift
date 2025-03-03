//
//  StandaloneListViewModel.swift
//  ProductViewer
//
//  Created by Thejus G on 01/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import Foundation
import Combine

/// Represents different states of the `StandaloneListViewModel`.
/// - `loading`: Data is being fetched.
/// - `loaded([Product])`: Data has been successfully loaded.
/// - `error(Error)`: An error occurred while fetching data.
enum StandaloneListViewModelState {
    case loading
    case loaded([Product])
    case error(Error)
    
    var products: [Product] {
        switch self {
        case .loaded(let deals):
            return deals
        case .loading, .error:
            return []
        }
    }
}

/// `ViewModel` responsible for fetching and managing product data.
final class StandaloneListViewModel {
    /// API client responsible for making network requests.
    private let apiClient: APIRequesting
    
    /// Set of cancellables to manage Combine subscriptions.
    var cancellables = Set<AnyCancellable>()
    
    /// Callback to notify the view controller when the state changes.
    var updatedState: (() -> Void)?
    
    /// Holds the current state of the view model.
    /// Updates the UI automatically when changed.
    var state: StandaloneListViewModelState = .loading {
        didSet {
            updatedState?() // Triggers the UI update whenever state changes.
        }
    }
    
    init(apiClient: APIRequesting = APIClient()) {
        self.apiClient = apiClient
    }
    
    /// Fetches product deals from the API.
    func fetchDeals() {
        let endPoint = StandaloneEndpointProvider.fetchDeals
        self.state = .loading
        apiClient.perfomRequest(endPoint: endPoint, responseModel: ProductList.self)
            .sink(receiveCompletion: { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error)
                case .finished: break
                }
            }, receiveValue: { (productList) in
                self.state = .loaded(productList.products)
            }).store(in: &cancellables)
    }
}
