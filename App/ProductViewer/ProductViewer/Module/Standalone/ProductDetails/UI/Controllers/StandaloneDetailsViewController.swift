//
//  StandaloneDetailsViewController.swift
//  ProductViewer
//
//  Created by Thejus G on 01/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import UIKit

/// ViewController responsible for displaying product details.
final class StandaloneDetailsViewController: UIViewController {
    //MARK: - UI Components
    
    /// ScrollView to enable vertical scrolling.
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .always
        return scrollView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let productImageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = .Details.title
        label.textColor = .black
        return label
    }()
    
    private let productDetailsLabel: UILabel = {
        let label = UILabel()
        label.font = .Details.emphasis
        label.textColor = .grayDarkest
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .Details.copy2
        label.textColor = .grayMedium
        return label
    }()
    
    private let productDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 24
        return stackView
    }()
    
    private let separatorView = SeparatorView()
    
    /// Price block view displaying product price details.
    private let priceBlockView = PriceBlockStackView()
    
    /// Activity indicator to show loading state.
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    private let viewModel: StandaloneDetailsViewModel
    
    // MARK: - Initialization
    
    /// Initializes with a ViewModel.
    /// - Parameter viewModel: ViewModel handling product details data.
    init(viewModel: StandaloneDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsHierarchy()
        setupConstraints()
        styleViews()
        configureNavigationBar()
        bindViewModel()
        viewModel.fetchProductDetails()
    }
    
    // MARK: - Navigation
    
    /// Action for the custom back button.
    @objc func backButtonTapped() {
        // Action for the back button
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Data Binding & UI Updates
    
    /// Configures the UI with product details from ViewModel.
    private func configureViews() {
        let detailedProduct = viewModel.state.product ?? viewModel.product
        productImage.setImage(from: detailedProduct.imageUrl ?? "")
        titleLabel.text = detailedProduct.title
        priceBlockView.setValues(detailedProduct.salePrice?.display_string ?? "",
                                 detailedProduct.regularPrice?.display_string ?? "",
                                 detailedProduct.fulfillment)
        productDetailsLabel.text = NSLocalizedString("productDetails", comment: "")
        descriptionLabel.text = detailedProduct.description
    }
    
    /// Binds the ViewModel's state changes to UI updates.
    private func bindViewModel() {
        viewModel.updatedState = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.updateFromViewModel()
            }
        }
    }
    
    /// Updates the UI based on ViewModel state.
    private func updateFromViewModel() {
        switch viewModel.state {
        case .loading:
            activityIndicator.startAnimating()
        case .loaded:
            activityIndicator.stopAnimating()
            configureViews()
        case .error:
            configureViews()
        }
    }
}

// MARK: - UI Setup Methods
private extension StandaloneDetailsViewController {
    func setupViewsHierarchy() {
        view.addAndPinSubview(scrollView)
        scrollView.addAndPinSubview(contentStackView, edges: [.top, .left, .right])
        scrollView.addAndPinSubview(separatorView, edges: [.left, .right])
        scrollView.addAndPinSubview(productDescriptionStackView, edges: [.left, .right, .bottom])
        view.addAndPinSubview(activityIndicator)
        contentStackView.addArrangedSubview(productImage)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(priceBlockView)
        productDescriptionStackView.addArrangedSubview(productDetailsLabel)
        productDescriptionStackView.addArrangedSubview(descriptionLabel)
        activityIndicator.backgroundColor = .background
    }
    
    func setupConstraints() {
        let width = (UIScreen.main.bounds.width - 32)
        NSLayoutConstraint.activate([
            productImage.widthAnchor.constraint(equalToConstant: width),
            productImage.heightAnchor.constraint(equalToConstant: width) //as ratio is 1:1
        ])
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor),
            productDescriptionStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 16)
        ])
    }
    
    func styleViews() {
        view.backgroundColor = .white
    }
    
    func configureNavigationBar() {
        // Create a custom back button with the system back arrow
        let backArrow = UIImage(named: "back_arrow")?.withRenderingMode(.alwaysOriginal) // SF Symbol for back arrow
        let backButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(backButtonTapped))
        
        // Set the custom back button
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.title = NSLocalizedString("detailsTitle", comment: "")
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = nil
    }
}

