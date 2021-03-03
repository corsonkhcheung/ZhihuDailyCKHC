//
//  StoryTableViewCell.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/16.
//

import UIKit

class StoryTableViewCell: UITableViewCell {
    
    private lazy var thumbnailImageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.textAlignment = .left
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
    
    var story: StoryInformation?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .default
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(thumbnailImageView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 100),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor,constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: authorLabel.topAnchor),
            
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: -20),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            authorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func SetUpCell(_ s:StoryInformation?) {
        
        self.story = s
        guard story != nil else { return }
        
        // MARK: - Setup Text for TableViewCell
        
        self.titleLabel.text = story?.title ?? "标题缺失"
        self.titleLabel.font = .systemFont(ofSize: 20, weight: .light)
        self.authorLabel.text = story?.hint ?? ""
        
        // MARK: - Setup Image for TableViewCell
        
        guard self.story!.images?[0] != "" else { return }
        if let cachedData = CacheManager.getStoryCache(self.story!.images?[0] ?? "") {
            self.thumbnailImageView.image = UIImage(data: cachedData)
        }
        let url = URL(string: self.story!.images?[0] ?? "https://www.notion.so/corsoncheung/97416469544f4c398415b160cd685394#ae76aac48a5a43328b8da2e1b3851bc7")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in

            if error == nil && data != nil {
                CacheManager.setStoryCache(url!.absoluteString, data)
                if url!.absoluteString != self.story?.images?[0] { return }
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }

            }
        }
        dataTask.resume()
        
    }

}
