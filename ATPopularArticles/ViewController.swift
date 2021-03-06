//
//  ViewController.swift
//  ATPopularArticles
//
//  Created by Alvin Tu on 2/8/21.
//  Copyright © 2021 Alvin Tu. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class ViewController: UIViewController {
    var articles = [Article]()
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New York Times"
        setUpCollectionView()
        fetchPopularArticles() //query doesn't work
        
        //TODO
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView?.reloadData()

    }
    
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width,
                                 height: view.frame.size.height - 35.0)
        collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView?.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: ArticleCollectionViewCell.identifier)
        collectionView?.isPagingEnabled = false
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
    }


    override func viewDidLayoutSubviews() {
        collectionView?.frame = view.bounds
    }
    
}
extension ViewController {
    //put in your own bearer token you get from twitter developer
    func fetchPopularArticles() {
        let bearerToken = ""
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(bearerToken)",
            "Accept": "application/json"
        ]
        
        let apiKey = ""
        AF.request("https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=\(apiKey)", headers: headers).responseDecodable(of:Articles.self) { response in
            if let articles = response.value {
                self.articles = articles.all
                self.collectionView?.reloadData()
            }
//            debugPrint(response)

        }
    }
}




extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard articles.count > 0 else {return 0}
        return articles.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let article = articles[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCollectionViewCell.identifier, for: indexPath) as! ArticleCollectionViewCell
        cell.configure(with: article)
        cell.delegate = self
        return cell
    }
    
    
}

extension ViewController: ArticleCollectionViewDelegate, WKNavigationDelegate{
    func didTapWebPageButton(with article: Article) {
        let webViewController = WebViewController()
        webViewController.url = article.url
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
}


