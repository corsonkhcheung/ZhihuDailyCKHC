//
//  ViewController.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/1.
//

import UIKit
import SafariServices

class ViewController: UIViewController,
                      UITableViewDelegate, UITableViewDataSource,
                      FeedModelDelegate {
    
    private lazy var headerView: UIView = {
       let v = HeaderView(fontSize: 32)
        return v
    }()
    
    private lazy var tableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.tableFooterView = UIView()
        v.register(StoryTableViewCell.self, forCellReuseIdentifier: Constants.STORYCELL_ID)
        v.dataSource = self
        v.delegate = self
        return v
    }()
    
    var cell: StoryTableViewCell!
    var model = Model()
    var stories = [StoryInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.feedModelDelegate = self
        
        setupView()
        model.getLatestFeed()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(tableView)
        setupConstraints()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    // MARK: - Model Delegate Methods
    
    func FeedFetched(_ stories: [StoryInformation]) {
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
        let selectedContentId = stories[tableView.indexPathForSelectedRow!.row].storyId
        detailPage.selectedContentId = selectedContentId
        self.navigationController?.pushViewController(detailPage, animated: true)
    }
    
}

