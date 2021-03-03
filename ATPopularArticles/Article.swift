//
//  Article.swift
//  ATPopularArticles
//
//  Created by Alvin Tu on 3/2/21.
//  Copyright © 2021 Alvin Tu. All rights reserved.
//

import Foundation



struct Article: Decodable {
    var id: Int
    var section: String
    var title: String
    var url: String
}

struct Articles: Decodable {
    var all: [Article]
    var status: String
    var copyright: String
    var num_results: Int
    
    enum CodingKeys: String, CodingKey {
        case all = "results"
        case status
        case copyright
        case num_results
    }
}


