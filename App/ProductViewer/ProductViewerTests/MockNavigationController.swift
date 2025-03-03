//
//  MockNavigationController.swift
//  ProductViewerTests
//
//  Created by Thejus G on 02/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import UIKit

// Mock Navigation Controller to track pushed view controllers
class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController // Capture the pushed view controller
        super.pushViewController(viewController, animated: animated)
    }
}
