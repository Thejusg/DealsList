//
//  MainCoordinator.swift
//  ProductViewer
//
//  Created by Thejus G on 01/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import UIKit

/// Protocol defining the basic structure for a Coordinator
protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start(animated: Bool)
}

/// Main Coordinator responsible for managing navigation within the app
final class MainCoordinator: Coordinator {
    
    // Navigation controller to manage the view hierarchy
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // Starts the coordinator by pushing the initial view controller
    func start(animated: Bool) {
        let standaloneListVC = StandaloneListViewController()
        standaloneListVC.coordinator = self
        navigationController.pushViewController(standaloneListVC, animated: animated)
    }
    
    // Navigates to the details screen with a specific product
    func showDetailsView(with dealsDetails: Product) {
        let viewModel = StandaloneDetailsViewModel(product: dealsDetails)
        let standaloneDetailsVC = StandaloneDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(standaloneDetailsVC, animated: true)
    }
}
