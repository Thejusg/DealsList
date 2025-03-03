//
//  Copyright © 2022 Target. All rights reserved.
//

import UIKit

/// Custom collection view cell that contains a `StandaloneListItemView`.
/// - Used in `StandaloneListViewController` to display product information.
class StandaloneListItemViewCell: UICollectionViewCell {
    
    /// The main view inside the cell that displays product details.
    lazy var listItemView: StandaloneListItemView = {
        let view = StandaloneListItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    private func setupViews() {
        contentView.addAndPinSubview(listItemView)
    }
}
