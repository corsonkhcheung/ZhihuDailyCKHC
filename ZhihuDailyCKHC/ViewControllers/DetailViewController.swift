//
//  DetailViewController.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/16.
//

import UIKit
//import WebKit
//import HTMLKit

class DetailViewController: UIViewController, ContentModelDelegate {
    
//    private let webView: WKWebView = {
//        let prefs = WKPreferences()
//        prefs.javaScriptEnabled = true
//        let config = WKWebViewConfiguration()
//        config.preferences = prefs
//        let v = WKWebView(frame: .zero, configuration: config)
//        return v
//    }()

    var selectedContentId: Int?
    
    var content: Content?
    var titleLabel: UILabel!
    
    public lazy var stretchyHeaderView: DetailStretchyHeaderView = {
        let v = DetailStretchyHeaderView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public lazy var textView: UITextView = {
        let v = UITextView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = content?.body
        return v
    }()
    
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.contentModelDelegate = self
        model.getContent(selectedContentId!)
        setupView()
        setupImage(content)
//        setupText(content)
    }
    
    func setupView() {
        view.backgroundColor = .white
//        webView.navigationDelegate = self
//        view.addSubview(webView)
        view.addSubview(stretchyHeaderView)
        view.addSubview(textView)
        setupConstraints()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stretchyHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stretchyHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stretchyHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            stretchyHeaderView.heightAnchor.constraint(equalToConstant: Constants.SCREEN.width),
            
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.topAnchor.constraint(equalTo: stretchyHeaderView.bottomAnchor, constant: 8),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Model Delegate Methods
        
    func ContentFetched(_ content: Content) {
        self.content = content
    }
    
    // MARK: - Setup Page Content
    
    func setupImage(_ content: Content?){
        
        self.content = content
        
        guard self.content?.image != "" else { return }
        if let cachedData = CacheManager.getStoryCache(self.content!.image ?? "") {
            self.stretchyHeaderView.imageView.image = UIImage(data: cachedData)
        }
        let url = URL(string: self.content!.image ?? "https://www.notion.so/corsoncheung/97416469544f4c398415b160cd685394#ae76aac48a5a43328b8da2e1b3851bc7")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in

            if error == nil && data != nil {
                CacheManager.setStoryCache(url!.absoluteString, data)
                if url!.absoluteString != self.content?.image { return }
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.stretchyHeaderView.imageView.image = image
                }

            }
        }
        dataTask.resume()
    }
    
//    func setupText(_ content: Content?) {
//
//        self.content = content
//
//        let body = content?.body
//
//    }
    
    // MARK: - WebView Methods
    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.evaluateJavaScript("document.body.innerHTML") { result, error in
//            guard let html = result as? String, error == nil else {
//                return
//            }
//            let document = HTMLDocument(string: html)
//
//        }
//    }
}


