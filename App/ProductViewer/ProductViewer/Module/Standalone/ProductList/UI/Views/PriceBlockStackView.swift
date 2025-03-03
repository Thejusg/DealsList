//
//  PriceBlockStackView.swift
//  ProductViewer
//
//  Created by Thejus G on 02/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import UIKit

/// A custom `UIStackView` for displaying product pricing details.
class PriceBlockStackView: UIStackView {
    //MARK: - UIView Components
    
    /// Stack view containing both sale price and regular price labels.
    private let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .firstBaseline
        stackView.spacing = 4
        return stackView
    }()
    
    private let regularPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .small
        label.textColor = .grayDarkest
        return label
    }()
    
    private let salePriceLabel: UILabel = {
        let label = UILabel()
        label.font = .largeBold
        label.textColor = .darkRed
        return label
    }()
    
    /// Label to display fulfillment information (e.g., "Online only", "In-store pickup").
    private let fullfilmentLabel: UILabel = {
        let label = UILabel()
        label.font = .small
        label.textColor = .textLightGray
        return label
    }()
    
    // MARK: - Initializer
    
    /// Initializes the `PriceBlockStackView` with predefined styling.
    init() {
        super.init(frame: .zero)
        axis = .vertical
        spacing = 4
        alignment = .leading
        priceStackView.addArrangedSubview(salePriceLabel)
        priceStackView.addArrangedSubview(regularPriceLabel)
        addArrangedSubview(priceStackView)
        addArrangedSubview(fullfilmentLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Method
    
    /// Sets the price values and fulfillment details.
    func setValues(_ salePrice: String, _ regularPrice: String, _ fullfilment: String) {
        regularPriceLabel.text = "reg. \(regularPrice)"
        salePriceLabel.text = salePrice
        fullfilmentLabel.text = fullfilment
    }
}
