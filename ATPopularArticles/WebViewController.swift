//
//  WebViewController.swift
//  ATPopularArticles
//
//  Created by Alvin Tu on 3/3/21.
//  Copyright © 2021 Alvin Tu. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController{
     var url: String?
    override func viewDidLoad(){
        super.viewDidLoad()
        let webView = WKWebView()
        if let url = self.url {
        webView.load(url)
        webView.allowsBackForwardNavigationGestures = true
        self.view = webView
        }
    }
}

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
