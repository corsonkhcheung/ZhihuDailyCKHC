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
        v.textColor = .white
        v.numberOfLines = 0
        return v
    }()
        
    private lazy var authorLabel: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
<<<<<<< HEAD
        v.textColor = .white
=======
        v.textColor = .systemGray
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2
        v.textAlignment = .left
        return v
    }()
    
<<<<<<< HEAD
//    private lazy var shadowImageView = ShadowImageView()
=======
    private lazy var shadowImageView = ShadowImageView()
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2

    var topStory: StoryInformation?
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
//        addSubview(shadowImageView)
        addSubview(imageView)
        addSubview(titleLabel)
<<<<<<< HEAD
        addSubview(authorLabel)
=======
        addSubview(shadowImageView)
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.SCREEN.width),
<<<<<<< HEAD
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: authorLabel.topAnchor, constant: -16),
            
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            authorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
//            shadowImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            shadowImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            shadowImageView.topAnchor.constraint(equalTo: topAnchor),
//            shadowImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
=======
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16)
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2
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
<<<<<<< HEAD
        let url = URL(string: self.topStory!.image ?? Constants.FILLER_IMAGE)
=======
        let url = URL(string: self.topStory!.image ?? "https://www.notion.so/corsoncheung/97416469544f4c398415b160cd685394#ae76aac48a5a43328b8da2e1b3851bc7")
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2
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
