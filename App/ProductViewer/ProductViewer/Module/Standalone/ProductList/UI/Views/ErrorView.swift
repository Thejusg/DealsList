//
//  ErrorView.swift
//  ProductViewer
//
//  Created by Thejus G on 02/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import UIKit

/// A custom `UIStackView` for displaying error messages.
/// It includes:
/// - An error icon (exclamation mark inside a triangle)
/// - A message label for displaying the error description
final class ErrorView: UIStackView {
    
    private let iconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "exclamationmark.triangle"))
        imageView.tintColor = .red
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializer
    
    /// Initializes the `ErrorView` with predefined styling.
    init() {
        super.init(frame: .zero)
        axis = .vertical
        spacing = 8
        alignment = .center
        addArrangedSubview(iconView)
        addArrangedSubview(messageLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Method
    
    /// Displays an error message in the view.
    ///
    /// - Parameter message: The error message to be displayed.
    func showError(message: String) {
        messageLabel.text = message
    }
}
