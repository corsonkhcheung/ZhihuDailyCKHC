//
//  ViewController.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/1.
//

import UIKit

class ViewController: UIViewController,
                      UITableViewDelegate, UITableViewDataSource,
                      UICollectionViewDataSource, UICollectionViewDelegate,
                      UIScrollViewDelegate,
                      FeedModelDelegate {
    
<<<<<<< HEAD
    let detailPage = DetailViewController()
    
    public lazy var headerView = HeaderView()
//    public lazy var feedPagerView = FeedPagerView()
//    public lazy var containerView: UIView = {
//        let v = UIView()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        return v
//    }()
=======
    public lazy var headerView = HeaderView()
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2
    
    private lazy var tableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.register(StoryTableViewCell.self, forCellReuseIdentifier: Constants.STORYCELL_ID)
        v.dataSource = self
        v.delegate = self
        return v
    }()
    
    private lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        v.translatesAutoresizingMaskIntoConstraints = false
        v.dataSource = self
        v.delegate = self
        v.register(FeedPagerCollectionViewCell.self, forCellWithReuseIdentifier: Constants.PAGINGCELL_ID)
        return v
    }()
    
    var cell: StoryTableViewCell!
    var model = Model()
    var stories = [StoryInformation]()
    var topStories = [StoryInformation]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.feedModelDelegate = self
        setupView()
        model.getLatestFeed()
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
<<<<<<< HEAD
    // MARK: - Setup UI
    
    func setupView() {
        view.backgroundColor = .white
=======
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupView() {
        view.backgroundColor = .white
//        view.addSubview(headerView)
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2
        view.addSubview(tableView)
//        containerView.addSubview(collectionView)
        
        setupConstraints()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
<<<<<<< HEAD
=======
//            headerView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 16),
//            headerView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor,constant: -16),
//            headerView.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor, constant: 10),
//            headerView.heightAnchor.constraint(equalToConstant: Constants.SCREEN.width + 100),
            
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    // MARK: - Model Delegate Methods
    
    func asignToStoriesFromFeedFetched(_ stories: [StoryInformation]) {
        self.stories = stories
    }
    func asignToStoriesFromPreviousFeedFetched(_ newStories: [StoryInformation]) {
        for i in 0...newStories.count - 1 { self.stories.append(newStories[i]) }
        tableView.reloadData()
    }
    func asignToTopStoriesFromFeedFetched(_ topStories: [StoryInformation]) {
        self.topStories = topStories
//        feedPagerView.topStories = topStories
//        self.fetchStoryObjects(topStories)
//        setupPager(topStories)
        collectionView.reloadData()
    }
    
    // MARK: - TableView Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: Constants.STORYCELL_ID, for: indexPath) as? StoryTableViewCell
        let story = self.stories[indexPath.row]
        cell.setupCell(story)
        cell.textLabel?.text = title
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
<<<<<<< HEAD
        let v = UIView(frame: CGRect(origin: CGPoint(x: Constants.SCREEN.width / 2, y: 0),size: CGSize(width: Constants.SCREEN.width, height: Constants.SCREEN.width + 120)))
=======
        let v = UIView(frame: CGRect(origin: CGPoint(x: Constants.SCREEN.width / 2, y: 0),size: CGSize(width: Constants.SCREEN.width, height: Constants.SCREEN.width + 100)))
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2
        v.setNeedsLayout()
        v.layoutIfNeeded()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(headerView)
<<<<<<< HEAD
//        v.addSubview(containerView)
        v.addSubview(collectionView)
//        v.addSubview(scrollView)
        NSLayoutConstraint.activate([
            
            headerView.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: v.trailingAnchor,constant: -16),
            headerView.topAnchor.constraint(equalTo: v.topAnchor, constant: 10),
            headerView.heightAnchor.constraint(equalToConstant: 50),
//            headerView.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -10),
            
            collectionView.leadingAnchor.constraint(equalTo: v.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: v.trailingAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: Constants.SCREEN.width),
            collectionView.heightAnchor.constraint(equalToConstant: Constants.SCREEN.width),
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: v.bottomAnchor),
            
//            scrollView.leadingAnchor.constraint(equalTo: v.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: v.trailingAnchor),
//            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: v.bottomAnchor)
=======
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: v.trailingAnchor,constant: -16),
            headerView.topAnchor.constraint(equalTo: v.topAnchor, constant: 10),
            headerView.bottomAnchor.constraint(equalTo: v.bottomAnchor,constant: -10)
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2
        ])
        return v
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
<<<<<<< HEAD
        Constants.SCREEN.width + 120
=======
        Constants.SCREEN.width + 50
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailPage = DetailViewController()
        guard tableView.indexPathForSelectedRow != nil else { return }
        detailPage.selectedContentId = stories[tableView.indexPathForSelectedRow!.row].storyId
        self.navigationController?.pushViewController(detailPage, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
<<<<<<< HEAD
    
    // MARK: - CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { topStories.count }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.PAGINGCELL_ID, for: indexPath) as! FeedPagerCollectionViewCell
        let topStory = self.topStories[indexPath.row]
        cell.SetUpCell(topStory)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailPage = DetailViewController()
        detailPage.selectedContentId = topStories[indexPath.row].storyId
        self.navigationController?.pushViewController(detailPage, animated: true)
    }
    
//    @objc open func handleTapGesture(_ gesture: UIGestureRecognizer) {
//        guard gesture.state == .ended else { return }
//        let touchLocation = gesture.location(in: collectionViewForTopStories)
//        if collectionViewForTopStories.frame.contains(touchLocation) {
//            self.navigationController?.pushViewController(detailPage, animated: true)
//            detailPage.selectedContentId = topStories[0].storyId
//        }
//    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets.bottom = 16
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(1)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration.scrollDirection = .horizontal
        return layout
    }
    
    // MARK: - Pager View Methods
    
//    var topStoryToConfigure: StoryInformation?
//    var i = 0
//
//    public lazy var scrollView: UIScrollView = {
//        let v = UIScrollView()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.contentSize = CGSize(width: Constants.SCREEN.width * 5, height: v.frame.size.height)
//        v.delegate = self
//        v.isPagingEnabled = true
//        return v
//    }()
//
//    private lazy var pageControl: UIPageControl = {
//       let v = UIPageControl()
//        v.numberOfPages = 5
//        return v
//    }()
//
//    private lazy var titleLabel: UILabel = {
//        let v = UILabel(frame: CGRect(x: 0, y: Constants.SCREEN.width - 100, width: Constants.SCREEN.width, height: 50))
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.textAlignment = .left
//        v.font = v.font.withSize(32)
//        return v
//    }()
//
//    private lazy var authorLabel: UILabel = {
//        let v = UILabel(frame: CGRect(x: 0, y: Constants.SCREEN.width - 50, width: Constants.SCREEN.width, height: 50))
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.textAlignment = .left
//        v.textColor = .systemGray
//        v.font = v.font.withSize(20)
//        return v
//    }()
//
//    private lazy var imageView: UIImageView = {
//        let v = UIImageView(frame: CGRect(x: 0, y: 0, width: Constants.SCREEN.width, height: Constants.SCREEN.width))
//        v.translatesAutoresizingMaskIntoConstraints = false
//        return v
//    }()
//
//    func fetchStoryObjects(_ s: [StoryInformation]) {
//        self.topStories = s
//    }
//
//    func setupPager(_ s: [StoryInformation]) {
//        for x in 0...4 {
//            let page = UIView(frame:CGRect(
//                                x: CGFloat(x) * Constants.SCREEN.width, y: 0,
//                                width: Constants.SCREEN.width, height: scrollView.frame.size.height
//                                )
//            )
//            setupContentInView(s[x])
//            page.addSubview(imageView)
//            page.addSubview(titleLabel)
//            page.addSubview(authorLabel)
//            scrollView.addSubview(page)
//        }
//    }
//
//    func pageNumberChanged(sender: AnyObject) {
//        if self.pageControl.currentPage == self.pageControl.numberOfPages - 1 {
//            self.pageControl.currentPage = 0
//        } else {
//            self.pageControl.currentPage += 1
//        }
//        let page: CGFloat = CGFloat(self.pageControl.currentPage)
//        let x = page * self.scrollView.frame.width
//        self.scrollView.contentOffset = CGPoint(x: x, y: 0)
//    }
//
////    func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        let pageNumber = scrollView.contentOffset.x / self.scrollView.frame.width
////        self.pageControl.currentPage = Int(floorf(Float(pageNumber)))
////    }
//
//    func setupContentInView(_ s: StoryInformation) {
//
//        self.topStoryToConfigure = s
//        guard topStoryToConfigure != nil else { return }
//
//        // MARK: - Setup Text for View
//
//        self.titleLabel.text = topStoryToConfigure?.title ?? "标题缺失"
//        self.titleLabel.font = .systemFont(ofSize: 32, weight: .semibold)
//        self.authorLabel.text = topStoryToConfigure?.hint ?? "没有阅读提示"
//        self.authorLabel.font = .systemFont(ofSize: 20, weight: .light)
//        self.authorLabel.textColor = .systemGray
//
//        // MARK: - Setup Image for View
//
//        let url = URL(string: topStoryToConfigure?.image ?? Constants.FILLER_IMAGE)
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: url!) { (data, response, error) in
//            if error == nil && data != nil {
//                CacheManager.setStoryCache(url!.absoluteString, data)
//                if url!.absoluteString != self.topStoryToConfigure?.image { return }
//                let image = UIImage(data: data!)
//                DispatchQueue.main.async {
//                    self.imageView.image = image
//                }
//            }
//        }
//        dataTask.resume()
//    }
//
//
//
=======
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let content: Content?
//        guard tableView.indexPathForSelectedRow != nil else { return }
//        let selectedContentId = stories[tableView.indexPathForSelectedRow!.row].storyId
//        model.getContent(selectedContentId!)
//        
//    }
//    
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2
}

