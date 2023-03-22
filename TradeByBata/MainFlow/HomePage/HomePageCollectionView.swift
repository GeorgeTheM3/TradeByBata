//
//  HomePageCollectionView.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 19.03.2023.
//

import UIKit

class HomePageCollectionView: UIViewController {
    
    @objc private var viewModel: HomePageViewModel
    private var statusObservation: NSKeyValueObservation?
    private lazy var dataSource = makeDataSource()
    private var homePageCollectionView: UICollectionView!
    
    private weak var passInfoToCell: PassProductToCellProtocol?
    private weak var passInfoToHeader: PassSettingsForHeaderProtocol?
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.frame = CGRect(x: Int(homePageCollectionView.bounds.width)/2, y: Int(homePageCollectionView.bounds.height)/2, width: 0, height: 0)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setObserver()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUserPhoto()
    }
    
    private func setupNavigationBar() {
        createCustomNavigationBar(title: "Trade by Bata")
        navigationItem.leftBarButtonItem = createBarButton(systemNameImage: "line.3.horizontal", selector: #selector(pressButton))
    }
    
    private func setUserPhoto() {
        var image: UIImage
        if let imageData = viewModel.getUserPhoto() {
            guard let photo = UIImage(data: imageData) else { return }
            image = photo
        } else {
            guard let defaultPhoto = UIImage(named: "default-user") else { return }
            image = defaultPhoto
        }
        navigationItem.rightBarButtonItem = createCustomBarButton(imageNamed: image, selector: #selector(pressButton))
    }
    
    @objc func pressButton() {
        print("press")
    }
    
    func supplementary(collectionView: UICollectionView, kind: Headers, indexPath: IndexPath) -> UICollectionReusableView? {
        switch kind {
        case .categories:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: Headers.categories.rawValue, withReuseIdentifier: Headers.categories.rawValue, for: indexPath) as! SearchBarHeaderView
            return header
        case .latest:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: Headers.latest.rawValue, withReuseIdentifier: Headers.latest.rawValue, for: indexPath) as! GroupHeaderView
            passInfoToHeader = header
            passInfoToHeader?.headerSettings("Latest", nil)
            return header
        case .flashSale:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: Headers.flashSale.rawValue, withReuseIdentifier: Headers.flashSale.rawValue, for: indexPath) as! GroupHeaderView
            passInfoToHeader = header
            passInfoToHeader?.headerSettings("Flash Sale", nil)
            return header
        case .brands:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: Headers.brands.rawValue, withReuseIdentifier: Headers.brands.rawValue, for: indexPath) as! GroupHeaderView
            passInfoToHeader = header
            passInfoToHeader?.headerSettings("Brands", nil)
            return header
        }
    }
    
    private func setupCollectionView() {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        homePageCollectionView = UICollectionView(frame: frame, collectionViewLayout: setCompositionLayout())
        view.addSubview(homePageCollectionView)
        view.addSubview(indicator)
        homePageCollectionView.backgroundColor = .systemBackgroundColor
        homePageCollectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.reuseId)
        homePageCollectionView.register(LatestCell.self, forCellWithReuseIdentifier: LatestCell.reuseId)
        homePageCollectionView.register(FlashSaleCell.self, forCellWithReuseIdentifier: FlashSaleCell.reuseId)
        homePageCollectionView.register(BrandCell.self, forCellWithReuseIdentifier: BrandCell.reuseId)
        
        homePageCollectionView.register(SearchBarHeaderView.self, forSupplementaryViewOfKind: Headers.categories.rawValue, withReuseIdentifier: Headers.categories.rawValue)
        homePageCollectionView.register(GroupHeaderView.self, forSupplementaryViewOfKind: Headers.latest.rawValue, withReuseIdentifier: Headers.latest.rawValue)
        homePageCollectionView.register(GroupHeaderView.self, forSupplementaryViewOfKind: Headers.flashSale.rawValue, withReuseIdentifier: Headers.flashSale.rawValue)
        homePageCollectionView.register(GroupHeaderView.self, forSupplementaryViewOfKind: Headers.brands.rawValue, withReuseIdentifier: Headers.brands.rawValue)
    }

    
    init(viewModel: HomePageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setObserver() {
        statusObservation = observe(\.viewModel.loadingStatus, options: .new) { key, change in
            guard let newValue =  change.newValue else { return }
            if !newValue {
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.updateDataSource(animated: true)
                }
            }
        }
    }
    
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Product > {
        return UICollectionViewDiffableDataSource(collectionView: homePageCollectionView, cellProvider: { collectionView,indexPath,itemIdentifier in
            let section = Section(rawValue: indexPath.section)!
            switch section {
            case .categories:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.reuseId, for: indexPath) as? CategoriesCell {
                    self.passInfoToCell = cell
                    self.passInfoToCell?.passProduct(itemIdentifier)
                    return cell
                }
            case .latest:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestCell.reuseId, for: indexPath) as? LatestCell {
                    self.passInfoToCell = cell
                    self.passInfoToCell?.passProduct(itemIdentifier)
                    cell.layer.cornerRadius = 15
                    cell.clipsToBounds = true
                    return cell
                }
            case .flashSale:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlashSaleCell.reuseId, for: indexPath) as? FlashSaleCell {
                    self.passInfoToCell = cell
                    self.passInfoToCell?.passProduct(itemIdentifier)
                    cell.layer.cornerRadius = 15
                    cell.clipsToBounds = true
                    return cell
                }
            case .brands:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCell.reuseId, for: indexPath) as? BrandCell {
                    self.passInfoToCell = cell
                    self.passInfoToCell?.passProduct(itemIdentifier)
                    cell.layer.cornerRadius = 15
                    cell.clipsToBounds = true
                    return cell
                }
            }
            return UICollectionViewCell()
        })
    }
    
    // MARK: для подстановки картинок из Assets
    func setImageFromAssets(productName: String) -> UIImage? {
        switch productName {
        case "New Balance Sneakers":
            return UIImage(named: "NewBalance")
        default:
            return nil
        }
    }
    
    func updateDataSource(animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product >()
        snapshot.appendSections(Section.allCases)
        
        
        self.dataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            return self.supplementary(collectionView: collectionView, kind: Headers(rawValue: kind) ?? .brands , indexPath: indexPath)
        }
    
        
        if viewModel.loadingStatus == false {
            snapshot.appendItems(viewModel.latestProducts, toSection: .latest)
            snapshot.appendItems(viewModel.flashSaleProducts, toSection: .flashSale)
        }
        
        snapshot.appendItems([Product(category: "PlayStation", name: "", price: 0, discount: nil, imageUrl: "ps", imageData: nil)], toSection: .brands)
        snapshot.appendItems([Product(category: "BMW", name: "", price: 0, discount: nil, imageUrl: "bmw", imageData: nil)], toSection: .brands)
        snapshot.appendItems([Product(category: "Reebok", name: "", price: 0, discount: nil, imageUrl: "reebok",imageData: nil)], toSection: .brands)
        snapshot.appendItems([Product(category: "Samsung", name: "", price: 0, discount: nil, imageUrl: "samsung",imageData: nil)], toSection: .brands)
        
        
        snapshot.appendItems([Product(category: "Phones", name: "", price: 0, discount: nil, imageUrl: "candybarphone", imageData: nil)], toSection: .categories)
        snapshot.appendItems([Product(category: "Headphones", name: "", price: 0, discount: nil, imageUrl: "headphones", imageData: nil)], toSection: .categories)
        snapshot.appendItems([Product(category: "Games", name: "", price: 0, discount: nil, imageUrl: "gamecontroller",imageData: nil)], toSection: .categories)
        snapshot.appendItems([Product(category: "Cars", name: "", price: 0, discount: nil, imageUrl: "car",imageData: nil)], toSection: .categories)
        snapshot.appendItems([Product(category: "Furniture", name: "", price: 0, discount: nil, imageUrl: "table.furniture",imageData: nil)], toSection: .categories)
        snapshot.appendItems([Product(category: "Kids", name: "", price: 0, discount: nil, imageUrl: "figure.and.child.holdinghands",imageData: nil)], toSection: .categories)
        self.dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    private func setCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0 :
                return self.categorySectionLayout()
            case 1 :
                return self.latestSectionLayout()
            case 2:
                return self.flashSaleSectionLayout()
            case 3:
                return self.brandSectionLayout()
            default:
                return self.brandSectionLayout()
            }
        }
        return layout
    }
    
    private func categorySectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/6),
                                              heightDimension: .fractionalWidth(1/5.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.18))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(0.06))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: Headers.categories.rawValue, alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
        
    }
    
    private func latestSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                               heightDimension: .fractionalWidth(0.4))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(0.04))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: Headers.latest.rawValue, alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func flashSaleSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                               heightDimension: .fractionalWidth(0.6))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(0.04))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: Headers.flashSale.rawValue, alignment: .top)

        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func brandSectionLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                               heightDimension: .fractionalWidth(0.4))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(0.03))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: Headers.brands.rawValue, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
        
    }
    
}
