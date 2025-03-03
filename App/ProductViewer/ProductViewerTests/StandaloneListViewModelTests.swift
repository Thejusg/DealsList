//
//  StandaloneListViewModelTests.swift
//  ProductViewerTests
//
//  Created by Thejus G on 02/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import XCTest
import Combine
@testable import ProductViewer

class StandaloneListViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    private var viewModel: StandaloneListViewModel!
    private var mockAPIClient: MockAPIClient!

    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        viewModel = StandaloneListViewModel(apiClient: mockAPIClient)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockAPIClient = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchDeals_Success() throws {
        let json = """
        {
          "products": [
            {
              "id": 0,
              "title": "VIZIO D-Series 40 Class 1080p Full-Array LED HD Smart TV",
              "aisle": "b2",
              "description": "fetch full product with details from https://api.target.com/mobile_case_study_deals/v1/deals/0",
              "image_url": "https://appstorage.target.com/app-data/native-tha-images/1.jpg",
              "regular_price": {
                "amount_in_cents": 22999,
                "currency_symbol": "$",
                "display_string": "$229.99"
              },
              "fulfillment": "Online",
              "availability": "In stock"
            },
            {
              "id": 1,
              "title": "TCL 32 Class 3-Series HD Smart Roku TV",
              "aisle": "g33",
              "description": "fetch full product with details from https://api.target.com/mobile_case_study_deals/v1/deals/1",
              "image_url": "https://appstorage.target.com/app-data/native-tha-images/2.jpg",
              "regular_price": {
                "amount_in_cents": 20999,
                "currency_symbol": "$",
                "display_string": "$209.99"
              },
              "sale_price": {
                "amount_in_cents": 15999,
                "currency_symbol": "$",
                "display_string": "$159.99"
              },
              "fulfillment": "Online",
              "availability": "In stock"
            }
          ]
        }
        """
        
        // Convert JSON string to Data
        guard let data = json.data(using: .utf8) else { throw DataError.decodingError }
        
        // Set the mock response for the APIClient
        mockAPIClient.mockResponse = data
        
        // Create expectation for the asynchronous network call
        let expectation = self.expectation(description: "Fetch Deals Success")
        
        // Set updatedState closure to handle state changes
        viewModel.updatedState = {
            if case .loaded(let products) = self.viewModel.state {
                // Validate the loaded products
                XCTAssertEqual(products.count, 2)
                XCTAssertEqual(products.first?.title, "VIZIO D-Series 40 Class 1080p Full-Array LED HD Smart TV")
                XCTAssertEqual(products.first?.regularPrice?.display_string, "$229.99")
                expectation.fulfill() // Fulfill the expectation once the validation is done
            }
        }

        // Act: Fetch deals
        viewModel.fetchDeals()

        // Wait for expectations to be fulfilled
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFetchDeals_Failure() {
        // Arrange
        let mockError = NSError(domain: "com.productviewer", code: 404, userInfo: [NSLocalizedDescriptionKey: "Not Found"])
        mockAPIClient.mockError = mockError
        
        // Create expectation
        let expectation = self.expectation(description: "Fetch Deals Failure")
        
        // Set updatedState closure to handle state changes
        viewModel.updatedState = {
            if case .error(let error) = self.viewModel.state {
                // Validate that the error matches the mock error
                XCTAssertEqual((error as NSError).code, 404)
                XCTAssertEqual((error as NSError).localizedDescription, "Not Found")
                expectation.fulfill()
            }
        }
        
        // Act
        viewModel.fetchDeals()
        
        // Wait for expectations
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

