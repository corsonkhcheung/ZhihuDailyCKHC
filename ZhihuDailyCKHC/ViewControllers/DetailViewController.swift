//
//  DetailViewController.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/16.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    var story:Story?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() { super.viewDidLoad() }
    override func viewWillAppear(_ animated: Bool) {
        guard story != nil else { return }
        let storyUrlString = "\(Constants.LATEST_NEWS_CONTENT) + \(String(describing: story?.storyId))"
        let url = URL(string: storyUrlString)
        let request = URLRequest(url: url!)
        webView.load(request)
    }

}
