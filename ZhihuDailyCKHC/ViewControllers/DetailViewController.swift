//
//  DetailViewController.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/16.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, ContentModelDelegate {
    
    private let webView: WKWebView = {
        let v = WKWebView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    var selectedContentId: Int?
    var storyTitle: String?
    
    var content: Content?
    
//    public lazy var stretchyHeaderView: DetailStretchyHeaderView = {
//        let v = DetailStretchyHeaderView()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        return v
//    }()
    
//    public lazy var textView: UITextView = {
//        let v = UITextView()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.text = content?.body
//        return v
//    }()
    
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.contentModelDelegate = self
        model.getContent(selectedContentId!)
        setupView()
        
        navigationController?.title = storyTitle
    }
    
    func setupView() {
        view.backgroundColor = .white
//        view.addSubview(stretchyHeaderView)
//        view.addSubview(textView)
        view.addSubview(webView)
        setupConstraints()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
//            stretchyHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            stretchyHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            stretchyHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
//            stretchyHeaderView.heightAnchor.constraint(equalToConstant: Constants.SCREEN.width),
//
//            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            textView.topAnchor.constraint(equalTo: stretchyHeaderView.bottomAnchor, constant: 8),
//            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Model Delegate Methods
        
    func ContentFetched(_ content: Content) {
        self.content = content
//        setupImage(content)
//        setupText(content)
        setupPage(content)
    }
    
    // MARK: - Setup Page Content
    
    func setupPage(_ content: Content?) {
        self.content = content
        let url = URL(string: (content?.shareURL)!)!
        webView.load(URLRequest(url: url))
    }
    
//    func setupImage(_ content: Content?) {
//
//        self.content = content
//
//        guard self.content?.image != "" else { return }
//        if let cachedData = CacheManager.getStoryCache(self.content!.image ?? "") {
//            self.stretchyHeaderView.imageView.image = UIImage(data: cachedData)
//        }
//        let url = URL(string: self.content!.image ?? Constants.FILLER_IMAGE)
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: url!) { (data, response, error) in
//
//            if error == nil && data != nil {
//                CacheManager.setStoryCache(url!.absoluteString, data)
//                if url!.absoluteString != self.content?.image { return }
//                let image = UIImage(data: data!)
//                DispatchQueue.main.async {
//                    self.stretchyHeaderView.imageView.image = image
//                }
//
//            }
//        }
//        dataTask.resume()
//    }
}

