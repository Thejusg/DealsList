//
//  Copyright © 2022 Target. All rights reserved.
//

import UIKit

/// ViewController responsible for displaying a list of standalone items.
/// - Uses a `UICollectionView` with a compositional layout.
/// - Handles loading, error, and content states via a `viewModel`.
/// - Supports navigation to a details screen through `MainCoordinator`.
final class StandaloneListViewController: UIViewController {
    //MARK: - UIView Components
    
    /// Define the layout for the collection View
    private lazy var layout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(172))  // Allows flexible height
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: nil, top: .fixed(8), trailing: nil, bottom: .fixed(8))
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(172))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    /// Error view to display error messages
    private let errorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    /// Collection view to display the list of items
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .background
        collectionView.backgroundView = activityIndicator
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StandaloneListItemViewCell.self)
        
        return collectionView
    }()
    
    /// Activity indicator to show loading state
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    private let viewModel: StandaloneListViewModel
    var coordinator: MainCoordinator?
    
    // MARK: - Initializer
    
    /// Initializes the view controller with a default or injected ViewModel.
    init(viewModel: StandaloneListViewModel = StandaloneListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("listTitle", comment: "")
        setupViewsHierarchy()
        bindViewModel()
        viewModel.fetchDeals()
    }
}

//MARK: - Helpers
private extension StandaloneListViewController {
    func setupViewsHierarchy() {
        view.addAndPinSubview(collectionView)
        view.addAndCenterSubview(errorView)
    }
    
    func bindViewModel() {
        viewModel.updatedState = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.updateFromViewModel()
            }
        }
    }
    
    func updateFromViewModel() {
        switch viewModel.state {
        case .loading:
            activityIndicator.startAnimating()
        case .loaded:
            activityIndicator.stopAnimating()
            collectionView.reloadData()
        case .error(let error):
            self.errorView.showError(message: (error as NSError).localizedDescription)
            errorView.isHidden = false
            activityIndicator.stopAnimating()
        }
    }
}

//MARK: - Collection View Data Source
extension StandaloneListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.state.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StandaloneListItemViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.listItemView.configure(for: viewModel.state.products[indexPath.row])
        return cell
    }
}

//MARK: - Collection View Delegate
extension StandaloneListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.showDetailsView(with: viewModel.state.products[indexPath.item])
    }
}
