//
//  ArticleCollectionViewCell.swift
//  ATPopularArticles
//
//  Created by Alvin Tu on 3/2/21.
//  Copyright © 2021 Alvin Tu. All rights reserved.
//

import UIKit
import Lottie

class ArticleCollectionViewCell: UICollectionViewCell {
    static let identifier = "ArticleCollectionViewCell"
    //Labels
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name:"HiraginoSans-W6", size:30.0)
        return label
    }()

    private var animationView: AnimationView  = {
        let animation = AnimationView(name:"news")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        return animation
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        addSubViews()
    }
    
    private func addSubViews() {
        contentView.addSubview(titleLabel)
        titleLabel.sizeToFit()
        contentView.addSubview(animationView)
        animationView.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size.width/2
        let width = contentView.frame.size.width
        let height = contentView.frame.size.height
        
        titleLabel.frame = CGRect(x: 10.0, y:0.0, width:width * 0.95 , height: height)
        animationView.frame = CGRect(x: 0, y: 0, width:width  , height: size)
        animationView.animationSpeed = 0.90

    }

    public func configure(with article: Article){
        titleLabel.text = article.title
        contentView.backgroundColor = .systemGray2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
