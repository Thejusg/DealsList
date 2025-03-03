//
//  StandaloneListItemView.swift
//  ProductViewer
//
//  Created by Thejus G on 02/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import UIKit

/// A `reusable UIView` representing a single list item in the standalone list
final class StandaloneListItemView: UIView {
    
    //MARK: - UIView Components
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// A vertical stack view for product details (title, price, availability)
    private let leftDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 14
        stackView.axis = .vertical
        return stackView
    }()
    
    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .medium
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 3
        return label
    }()
    
    private let availabilityLabel: UILabel = {
        let label = UILabel()
        label.font = .medium
        label.textColor = .targetTextGreen
        return label
    }()
    
    /// Label to show aisle information where the product is located
    private let aisleLabel: UILabel = {
        let label = UILabel()
        label.font = .medium
        label.textColor = .textLightGray
        return label
    }()
    
    /// Horizontal stack view containing availability and aisle labels
    private let availablitiyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        return stackView
    }()
    
    /// A thin gray separator line for visual separation between list items
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return view
    }()
    
    private let priceBlockView: PriceBlockStackView = {
        let stackView = PriceBlockStackView()
        return stackView
    }()
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setupViewsHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configures the list item view with product data
    func configure(for listItem: Product) {
        titleLabel.text = listItem.title
        availabilityLabel.text = listItem.availability
        aisleLabel.text = "in aisle \(listItem.aisle.capitalized)"
        productImage.setImage(from: listItem.imageUrl ?? "")
        priceBlockView.setValues(listItem.salePrice?.display_string ?? "",
                                 listItem.regularPrice?.display_string ?? "",
                                 listItem.fulfillment)
    }
}

private extension StandaloneListItemView {
    /// Adds subviews to the view hierarchy and arranges them
    func setupViewsHierarchy() {
        addAndPinSubview(separatorLine, edges: [.top, .left, .right], insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        addAndPinSubview(mainStackView, edges: [.left, .right, .bottom])
        
        mainStackView.addArrangedSubview(productImage)
        mainStackView.addArrangedSubview(leftDescriptionStackView)
        leftDescriptionStackView.addArrangedSubview(priceBlockView)
        leftDescriptionStackView.addArrangedSubview(titleLabel)
        availablitiyStackView.addArrangedSubview(availabilityLabel)
        availablitiyStackView.addArrangedSubview(aisleLabel)
        leftDescriptionStackView.addArrangedSubview(availablitiyStackView)
    }
    
    /// Applies constraints to ensure proper layout
    func setupConstraints() {
        let heightCOnstrants = productImage.heightAnchor.constraint(equalToConstant: 140)
        heightCOnstrants.priority = UILayoutPriority(999)
        heightCOnstrants.isActive = true
        productImage.widthAnchor.constraint(equalToConstant: 140).isActive = true
        mainStackView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor).isActive = true
    }
}
