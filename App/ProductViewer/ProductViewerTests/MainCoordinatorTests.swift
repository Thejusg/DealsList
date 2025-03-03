//
//  MainCoordinatorTests.swift
//  ProductViewerTests
//
//  Created by Thejus G on 02/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import XCTest
import UIKit
@testable import ProductViewer

final class MainCoordinatorTests: XCTestCase {
    
    var coordinator: MainCoordinator!
    var mockNavigationController: MockNavigationController!

    override func setUp() {
        super.setUp()
        mockNavigationController = MockNavigationController() // Initialize mock navigation controller
        coordinator = MainCoordinator(navigationController: mockNavigationController) // Initialize coordinator with mock navigation controller
    }

    override func tearDown() {
        coordinator = nil
        mockNavigationController = nil
        super.tearDown()
    }

    // Test if start(animated:) correctly pushes StandaloneListViewController
    func testStart_PushesStandaloneListViewController() {
        // Act
        coordinator.start(animated: false)

        // Assert
        XCTAssertTrue(mockNavigationController.pushedViewController is StandaloneListViewController,
                      "start(animated:) should push StandaloneListViewController")
    }

    // Test if showDetailsView(with:) correctly pushes StandaloneDetailsViewController
    func testShowDetailsView_PushesStandaloneDetailsViewController() {
        // Arrange
        let dummyProduct = Product(id: 1, title: "Table", aisle: "w20", description: "Study Table", fulfillment: "online", availability: "in stock") // Provide necessary dummy data

        // Act
        coordinator.showDetailsView(with: dummyProduct)
        mockNavigationController.pushedViewController?.loadViewIfNeeded()
        
        // Assert
        XCTAssertTrue(mockNavigationController.pushedViewController is StandaloneDetailsViewController,
                      "showDetailsView(with:) should push StandaloneDetailsViewController")
    }
}
