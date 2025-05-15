//
//  File.swift
//  elGrocerAssignment
//
//  Created by Ibrar Ahmed on 15/05/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: HomeViewModel
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, HomeItem>!

    private var bannerTimer: Timer?
    private var currentBannerIndex = 0
    let loader = UIActivityIndicatorView(style: .large)
    
    // MARK: - Sections
    
    enum Section: Int, CaseIterable {
        case banners, categories, products
    }
    
    // MARK: - Initializers
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"
        
        setupCollectionView()
        configureDataSource()
        loadData()
        startBannerTimer()
        setupLoader()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        bannerTimer?.invalidate()
        bannerTimer = nil
    }
    
    // MARK: - UI Setup
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(HomeItemCell.self, forCellWithReuseIdentifier: HomeItemCell.identifier)
    }
    
    private func setupLoader() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        view.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Layout
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            let sectionType = Section.allCases[sectionIndex]
            
            switch sectionType {
            case .banners:
                return self.createBannerSection()
            case .categories:
                return self.createCategoriesSection()
            case .products:
                return self.createProductsSection()
            }
        }
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(180)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: itemSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    
    private func createCategoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Horizontal group (4 items wide)
        let horizontalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100)
        )
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: horizontalGroupSize,
            subitems: [item]
        )
        horizontalGroup.interItemSpacing = .fixed(15)
        
        // Vertical group with 2 horizontal groups (2 rows)
        let verticalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.95),
            heightDimension: .absolute(220)
        )
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: verticalGroupSize,
            subitems: [horizontalGroup, horizontalGroup]
        )
        verticalGroup.interItemSpacing = .fixed(20)
        
        let section = NSCollectionLayoutSection(group: verticalGroup)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        return section
    }
    
    private func createProductsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .absolute(250)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(250)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    // MARK: - Data Source
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, HomeItem>(collectionView: collectionView) { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeItemCell.identifier,
                for: indexPath
            ) as? HomeItemCell else {
                fatalError("Could not dequeue HomeItemCell")
            }
            
            cell.backgroundColor = UIColor.systemGray6
            cell.configure(with: item)
            return cell
        }
    }
    
    // MARK: - Data Loading
    
    private func loadData() {
        loader.startAnimating()
        viewModel.fetchData { [weak self] in
            guard let self = self else { return }
            self.loader.stopAnimating()
            
            var snapshot = NSDiffableDataSourceSnapshot<Section, HomeItem>()
            snapshot.appendSections([.banners, .categories, .products])
            snapshot.appendItems(self.viewModel.banners, toSection: .banners)
            snapshot.appendItems(self.viewModel.categories, toSection: .categories)
            snapshot.appendItems(self.viewModel.products, toSection: .products)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    // MARK: - Banner Auto Scroll
    
    private func startBannerTimer() {
        bannerTimer = Timer.scheduledTimer(
            timeInterval: 3.0,
            target: self,
            selector: #selector(scrollToNextBanner),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc private func scrollToNextBanner() {
        guard !viewModel.banners.isEmpty else { return }
        
        currentBannerIndex = (currentBannerIndex + 1) % viewModel.banners.count
        let indexPath = IndexPath(item: currentBannerIndex, section: Section.banners.rawValue)
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
