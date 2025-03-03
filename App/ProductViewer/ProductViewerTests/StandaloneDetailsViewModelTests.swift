//
//  StandaloneDetailsViewModelTests.swift
//  ProductViewerTests
//
//  Created by Thejus G on 02/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import XCTest
import Combine
@testable import ProductViewer


class StandaloneDetailsViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    private var product: Product!
    private var viewModel: StandaloneDetailsViewModel!
    private var mockAPIClient: MockAPIClient!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        product = Product(id: 1, title: "Women's Joybees Varsity Clog", aisle: "w20", description: "he 3-Series TCL Roku TV puts all your entertainment favorites in one place, allowing seamless access to thousands of streaming channels.", fulfillment: "online", availability: "in stock")
        viewModel = StandaloneDetailsViewModel(product: product, apiClient: mockAPIClient)
        cancellables = []
    }

    override func tearDown() {
        mockAPIClient = nil
        product = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchProductDetails_Success() throws {
        let json = """
    {
        "id": 1,
        "title": "TCL 32 Class 3-Series HD Smart Roku TV",
        "aisle": "g33",
        "description": "The 3-Series TCL Roku TV puts all your entertainment favorites in one place, allowing seamless access to thousands of streaming channels. The simple, personalized home screen allows seamless access to thousands of streaming channels, plus your cable box, Blu-ray player, gaming console, and other devices without flipping through inputs or complicated menus. Easy Voice Control lets you control your entertainment using just your voice. The super-simple remote—with about half the number of buttons on a traditional TV remote—puts you in control of your favorite entertainment. Cord cutters can access free, over-the-air HD content with the Advanced Digital TV Tuner or watch live TV from popular cable-replacement services like YouTube TV, Sling, Hulu and more.",
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
    """
        // Convert JSON string to Data
        guard let data = json.data(using: .utf8) else { throw DataError.decodingError }
        
        // Set the mock response for the APIClient
        mockAPIClient.mockResponse = data
        
        // Create expectation for the asynchronous network call
        let expectation = self.expectation(description: "Fetch Deals Success")
        
        // Set updatedState closure to handle state changes
        viewModel.updatedState = {
            if case .loaded(let productDetails) = self.viewModel.state {
                // Validate the loaded products
                XCTAssertEqual(productDetails.id, 1)
                XCTAssertEqual(productDetails.title, "TCL 32 Class 3-Series HD Smart Roku TV")
                XCTAssertEqual(productDetails.regularPrice?.display_string, "$209.99")
                expectation.fulfill() // Fulfill the expectation once the validation is done
            }
        }
        
        // Act: Fetch deals
        viewModel.fetchProductDetails()
        
        // Wait for expectations to be fulfilled
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchProductDetails_Failure() {
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
        viewModel.fetchProductDetails()
        
        // Wait for expectations
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}


//final class StandaloneDetailsViewControllerTests: XCTestCase {
//    
//    var viewController: StandaloneListViewController!
//    
//    override func setUp() {
//        super.setUp()
//        viewController = StandaloneListViewController()
//        
//        // 👇 Manually load the view to trigger viewDidLoad()
//        viewController.loadViewIfNeeded()
//    }
//
//    override func tearDown() {
//        viewController = nil
//        mockViewModel = nil
//        super.tearDown()
//    }
//    
//    func testViewDidLoad_CallsFetchProductDetails() {
//        XCTAssertTrue(mockViewModel.fetchProductDetailsCalled, "fetchProductDetails() should be called in viewDidLoad")
//    }
//}
