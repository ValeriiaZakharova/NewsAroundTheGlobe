//
//  NewsModel.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 16.10.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

struct NewsModel: Decodable {
    var source: [Source]
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var content: String?
    
    func date() -> Date? {
        let fornatter = ISO8601DateFormatter()
        return fornatter.date(from: publishedAt)
    }
}

struct Source: Decodable {
    var id: String?
    var name: String
}


