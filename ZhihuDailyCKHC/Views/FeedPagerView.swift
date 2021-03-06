//
//  FeedPagerView.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/3/4.
//

import UIKit

class FeedPagerView: UIView {
    
    var topStories: [StoryInformation]?
    var topStoryToConfigure: StoryInformation?
    var i = 0
    
    func fetchStoryObjects(_ s: [StoryInformation]) {
        self.topStories = s
    }
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textAlignment = .left
        v.font = v.font.withSize(32)
        return v
    }()
    
    private lazy var authorLabel: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textAlignment = .left
        v.textColor = .systemGray
        v.font = v.font.withSize(20)
        return v
    }()
    
    private lazy var imageView: UIImageView = {
       let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContentInView(_ s: StoryInformation) {
        
        self.topStoryToConfigure = s
        guard topStoryToConfigure != nil else { return }
        
        // MARK: - Setup Title for View
        
        self.titleLabel.text = topStoryToConfigure?.title ?? "标题缺失"
        self.titleLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        self.authorLabel.text = topStoryToConfigure?.hint ?? ""
        
        // MARK: - Setup Image for View
        
        let url = URL(string: topStoryToConfigure?.image ?? Constants.FILLER_IMAGE)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                CacheManager.setStoryCache(url!.absoluteString, data)
                if url!.absoluteString != self.topStoryToConfigure?.image { return }
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        dataTask.resume()
    }
    
    
    func setupView() {
        for i in 0...4 {
            setupContentInView(topStories![i])
            setupConstraints()
        }
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    

}

