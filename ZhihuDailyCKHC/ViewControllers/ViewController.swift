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
    
    public lazy var headerView = HeaderView()
    
    private lazy var tableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.register(StoryTableViewCell.self, forCellReuseIdentifier: Constants.STORYCELL_ID)
        v.dataSource = self
        v.delegate = self
        return v
    }()
    
    var cell: StoryTableViewCell!
    var model = Model()
    var stories = [StoryInformation]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.feedModelDelegate = self
        
        setupView()
        model.getLatestFeed()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupView() {
        view.backgroundColor = .white
//        view.addSubview(headerView)
        view.addSubview(tableView)
        setupConstraints()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
//            headerView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 16),
//            headerView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor,constant: -16),
//            headerView.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor, constant: 10),
//            headerView.heightAnchor.constraint(equalToConstant: Constants.SCREEN.width + 100),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView(frame: CGRect(origin: CGPoint(x: Constants.SCREEN.width / 2, y: 0),size: CGSize(width: Constants.SCREEN.width, height: Constants.SCREEN.width + 100)))
        v.setNeedsLayout()
        v.layoutIfNeeded()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: v.trailingAnchor,constant: -16),
            headerView.topAnchor.constraint(equalTo: v.topAnchor, constant: 10),
            headerView.bottomAnchor.constraint(equalTo: v.bottomAnchor,constant: -10)
        ])
        return v
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.SCREEN.width + 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailPage = DetailViewController()
        guard tableView.indexPathForSelectedRow != nil else { return }
        let selectedContentId = stories[tableView.indexPathForSelectedRow!.row].storyId
        detailPage.selectedContentId = selectedContentId
        self.navigationController?.pushViewController(detailPage, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let content: Content?
//        guard tableView.indexPathForSelectedRow != nil else { return }
//        let selectedContentId = stories[tableView.indexPathForSelectedRow!.row].storyId
//        model.getContent(selectedContentId!)
//        
//    }
//    
}

