//
//  ArticleCollectionViewCell.swift
//  ATPopularArticles
//
//  Created by Alvin Tu on 3/2/21.
//  Copyright © 2021 Alvin Tu. All rights reserved.
//

import UIKit
import Lottie

protocol ArticleCollectionViewDelegate {
func didTapWebPageButton(with article:Article)
}

class ArticleCollectionViewCell: UICollectionViewCell {
    static let identifier = "ArticleCollectionViewCell"
    private var article: Article?
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
        let randomBool = Bool.random()
        if randomBool{
        let animation = AnimationView(name:"news")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        return animation

        }
        else {
        let animation = AnimationView(name:"news1")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        return animation}
    }()
    
    private let webPageButton : UIButton = {
        let button = UIButton()
        button.setTitle("READ FULL NYT ARTICLE", for: .normal)
        button.tintColor = .red
        button.backgroundColor = .gray
        button.layer.cornerRadius = 25.0
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        addSubViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    private func addSubViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(webPageButton)
        contentView.addSubview(animationView)

        titleLabel.sizeToFit()
        animationView.play()
        webPageButton.addTarget(self, action: #selector(didTapWebPageButton), for: .touchDown)

    }
    
    //actions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size.width/2
        let width = contentView.frame.size.width
        let height = contentView.frame.size.height
        
        titleLabel.frame = CGRect(x: 10.0, y:0.0, width:width * 0.95 , height: height)
        animationView.frame = CGRect(x: 0, y: 0, width:width  , height: size)
        animationView.animationSpeed = 0.90
        
        webPageButton.frame = CGRect(x: 10, y:height/1.25, width:width * 0.90 , height: 50.0)


    }
    
    @objc private func didTapWebPageButton(){
        guard let article = article else {return}
        print("ahhh")
        delegate?.didTapWebPageButton(with: article)
    }

    public func configure(with article: Article){
        self.article = article
        titleLabel.text = article.title
        contentView.backgroundColor = .systemGray2
        
    }
    //delegate
    var delegate:ArticleCollectionViewDelegate?

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
