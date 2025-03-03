//
//  SeparatorView.swift
//  ProductViewer
//
//  Created by Thejus G on 02/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import UIKit

// MARK: - SeparatorView
/// A reusable view that displays two horizontal separator lines with spacing between them.
/// This is useful for visually separating sections in the UI.
final class SeparatorView: UIView {
    // MARK: - UI Components
    
    /// Top separator line with a thin gray border.
    private let topLine: UIView = {
        let view = UIView()
        view.backgroundColor = .thinBorderGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    /// Bottom separator line with a thin gray border.
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .thinBorderGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    // MARK: - Initializers
    
    /// Initializes the separator view programmatically.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    /// Adds and constraints the separator lines inside the view.
    private func setupViews() {
        addSubview(topLine)
        NSLayoutConstraint.activate([
            topLine.topAnchor.constraint(equalTo: topAnchor),
            topLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            topLine.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        addSubview(bottomLine)
        NSLayoutConstraint.activate([
            bottomLine.topAnchor.constraint(equalTo: topLine.bottomAnchor, constant: 16),
            bottomLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        backgroundColor = .background
    }
}
