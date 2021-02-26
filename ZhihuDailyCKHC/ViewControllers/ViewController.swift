//
//  ViewController.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/1.
//

import SwiftUI
import UIKit

class ViewController: UIViewController,
                      UITableViewDelegate, UITableViewDataSource,
                      UICollectionViewDelegate, UICollectionViewDataSource,
                      ModelDelegate {
    
    var tableView: UITableView!
    var cell: StoryTableViewCell!
    var collectionView: UICollectionView!
    var model = Model()
    var stories = [Story]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: Constants.SCREEN, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerView()
        tableView.register(StoryTableViewCell.self, forCellReuseIdentifier: Constants.STORYCELL_ID)
        view.addSubview(tableView)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FeedPagerCollectionViewCell.self, forCellWithReuseIdentifier: Constants.PAGINGCELL_ID)
        view.addSubview(collectionView)
        
        model.delegate = self
        model.getStory()
    }
    // MARK: - Model Methods
    
    func storiesFetched(_ stories: [Story]) {
        self.stories = stories
        tableView.reloadData()
    }
    
    // MARK: - TableView Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: Constants.STORYCELL_ID, for: indexPath) as? StoryTableViewCell
        let story = self.stories[indexPath.row]
        cell.SetUpCell(story)
        cell.textLabel?.text = title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailPage = DetailViewController()
        guard tableView.indexPathForSelectedRow != nil else { return }
        let selectedStory = stories[tableView.indexPathForSelectedRow!.row]
        detailPage.story = selectedStory
        self.navigationController?.pushViewController(detailPage, animated: true)
    }
    
    private func headerView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 300))
        view.backgroundColor = .blue
        return view
    }
    
    // MARK: - CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 5 }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.PAGINGCELL_ID, for: indexPath)
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

