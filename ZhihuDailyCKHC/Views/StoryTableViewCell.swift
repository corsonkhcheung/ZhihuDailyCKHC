//
//  StoryTableViewCell.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/16.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    var thumbnailImageView = UIImageView(frame: CGRect(x: 5, y: 5, width: Constants.SCREEN.width - 10 , height: 50))
    var titleLabel = UILabel(frame: CGRect(x: 5, y: 55, width: Constants.SCREEN.width - 10, height: 10))
//    var dateLabel = UILabel(frame: CGRect(x: 5, y: 65, width: Constants.SCREEN.width - 10, height: 10))
    var story: Story?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
//        contentView.addSubview(dateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func SetUpCell(_ s:Story?) {
        
        self.story = s
        
        guard story != nil else { return }
        
        self.titleLabel.text = story?.title
        
//        let converter = DateFormatter()
//        converter.dateFormat = "yyyymmdd"
//        self.dateLabel.text = response!.date
        
        guard self.story!.image != "" else { return }

        if let cachedData = CacheManager.getStoryCache(self.story!.image ?? "") {
            self.thumbnailImageView.image = UIImage(data: cachedData)
            return
        }

        let url = URL(string: self.story!.image ?? "")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in

            if error == nil && data != nil {
                CacheManager.setStoryCache(url!.absoluteString, data)
                if url!.absoluteString != self.story?.image { return }
                let image = UIImage(data: data!)
                DispatchQueue.main.async { self.thumbnailImageView.image = image }

            }
        }
        dataTask.resume()
    }

}

