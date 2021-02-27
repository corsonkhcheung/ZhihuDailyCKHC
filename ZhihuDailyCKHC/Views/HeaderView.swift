//
//  FeedPagerCollectionViewCell.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/25.
//

import UIKit

class HeaderView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var fontSize: CGFloat
    
    private lazy var collectionView: UICollectionView = {
        let v = UICollectionView()
        v.collectionViewLayout = self.createLayout()
        v.dataSource = self
        v.delegate = self
        v.register(FeedPagerCollectionViewCell.self, forCellWithReuseIdentifier: Constants.PAGINGCELL_ID)
        return v
    }()
    
    private lazy var titleLabelView: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = v.font.withSize(fontSize)
        v.numberOfLines = 0
        v.textColor = .gray
        return v
    }()
    
    init(fontSize: CGFloat) {
        self.fontSize = fontSize
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        
        addSubview(collectionView)
        addSubview(titleLabelView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabelView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
    }
    
    // MARK: - CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 5 }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.PAGINGCELL_ID, for: indexPath) as! FeedPagerCollectionViewCell
        cell.backgroundColor = .red
        return cell
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets.leading = 2
        item.contentInsets.trailing = 2
        item.contentInsets.bottom = 16
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(300)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        return UICollectionViewCompositionalLayout(section: section)
    }
}
