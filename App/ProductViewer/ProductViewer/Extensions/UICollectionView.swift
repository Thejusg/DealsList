//
//  UICollectionView.swift
//  ProductViewer
//
//  Created by Thejus G on 01/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import UIKit

// MARK: - ReusableView Protocol
/// A protocol that provides a reusable identifier for any view (like UICollectionViewCell or UITableViewCell).
protocol ReusableView: AnyObject {
    /// Default reuse identifier derived from the class name.
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

// MARK: - UICollectionView Extensions
/// Conforming UICollectionViewCell to `ReusableView` so all cells automatically have a reuse identifier.
extension UICollectionViewCell: ReusableView {}

extension UICollectionView {
    /// Registers a UICollectionViewCell subclass with the collection view.
    /// - Parameter _: The UICollectionViewCell type to register.
    func register<T: UICollectionViewCell>(_ : T.Type) where T: UICollectionViewCell {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    /// Dequeues a reusable cell of the expected type in a type-safe manner.
    /// - Parameters:
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A dequeued cell of the expected type.
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
