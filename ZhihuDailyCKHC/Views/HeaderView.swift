//
//  FeedPagerCollectionViewCell.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/25.
//

import UIKit

class HeaderView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, FeedModelDelegate {
    
    var model = Model()
    var topStories = [StoryInformation]()
    
    private lazy var collectionViewForTopStories: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        v.translatesAutoresizingMaskIntoConstraints = false
        v.dataSource = self
        v.delegate = self
        v.register(FeedPagerCollectionViewCell.self, forCellWithReuseIdentifier: Constants.PAGINGCELL_ID)
        return v
    }()
    
//    private lazy var titleLabelView: UILabel = {
//        let v = UILabel()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.font = v.font.withSize(32)
//        v.numberOfLines = 0
//        v.textColor = .gray
//        return v
//    }()
    
    private lazy var dateView: UILabel = {
        let v = UILabel()
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: currentDate)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = v.font.withSize(20)
        v.textColor = .gray
        v.text = dateString
        v.textAlignment = .left
        return v
    }()
    
    private lazy var headingLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "知乎日报CKHC"
        v.textAlignment = .left
        v.font = v.font.withSize(32)
        return v
    }()

//    private lazy var headerStackView: UIStackView = {
//        let v = UIStackView(arrangedSubviews: [headingLabel, dateView])
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.axis = .horizontal
//        v.alignment = .fill
//        return v
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        
        addSubview(collectionViewForTopStories)
//        addSubview(titleLabelView)
//        addSubview(headerStackView)
        addSubview(dateView)
        addSubview(headingLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            headingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headingLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            dateView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor),
            dateView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
//            headerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            headerStackView.heightAnchor.constraint(equalToConstant: 100),
            
            collectionViewForTopStories.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewForTopStories.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewForTopStories.topAnchor.constraint(equalTo: headingLabel.bottomAnchor),
            
//            titleLabelView.bottomAnchor.constraint(equalTo: collectionViewForTopStories.bottomAnchor)
        ])
    }
    
    // MARK: - Model Delegate Methods
    func FeedFetched(_ stories: [StoryInformation]) {
        self.topStories = stories
        collectionViewForTopStories.reloadData()
    }
    
    // MARK: - CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { topStories.count }
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
