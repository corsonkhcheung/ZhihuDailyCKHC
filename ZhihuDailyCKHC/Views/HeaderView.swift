//
//  FeedPagerCollectionViewCell.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/25.
//

import UIKit

class HeaderView: UIView {
    
    private lazy var dateView: UILabel = {
        let v = UILabel()
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        let dateString = formatter.string(from: currentDate)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = v.font.withSize(20)
        v.textColor = .gray
        v.text = dateString
        v.textAlignment = .right
        return v
    }()
    
    private lazy var headingLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "知乎日报CKHC"
        v.textAlignment = .left
        v.font = v.font.withSize(32)
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
    
    
    func setupView() {
        addSubview(dateView)
        addSubview(headingLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            headingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headingLabel.trailingAnchor.constraint(equalTo: dateView.leadingAnchor),
            headingLabel.topAnchor.constraint(equalTo: topAnchor),

            dateView.centerYAnchor.constraint(equalTo: headingLabel.centerYAnchor),
            dateView.leadingAnchor.constraint(equalTo: headingLabel.trailingAnchor, constant: 8),
            dateView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
    }
    

}
