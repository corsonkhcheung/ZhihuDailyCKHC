//
//  FeedPagerCollectionViewCell.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/28.
//

import UIKit

class FeedPagerCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        return v
    }()
        
    private lazy var authorLabel: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.textColor = .systemGray
        v.textAlignment = .left
        return v
    }()
    
    private lazy var shadowImageView = ShadowImageView()

    var topStory: StoryInformation?
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(shadowImageView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.SCREEN.width),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func SetUpCell(_ s:StoryInformation?) {
        
        self.topStory = s
        guard topStory != nil else { return }
        
        // MARK: - Setup Title for CollectionViewCell
        
        self.titleLabel.text = topStory?.title ?? "标题缺失"
        self.titleLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        self.authorLabel.text = topStory?.hint ?? ""
        
        // MARK: - Setup Image for CollectionViewCell
        
        guard self.topStory!.image != "" else { return }
        if let cachedData = CacheManager.getStoryCache(self.topStory!.image ?? "") {
            self.imageView.image = UIImage(data: cachedData)
        }
        let url = URL(string: self.topStory!.image ?? "https://www.notion.so/corsoncheung/97416469544f4c398415b160cd685394#ae76aac48a5a43328b8da2e1b3851bc7")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in

            if error == nil && data != nil {
                CacheManager.setStoryCache(url!.absoluteString, data)
                if url!.absoluteString != self.topStory?.image { return }
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        dataTask.resume()
        
    }

}
