//
//  NewsViewModel.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 09.11.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

struct NewsViewModel {
    var source: Source
    var author: String?
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
    
    var isFavorite = false
    
/// unique identifire for each news
    var identifier = UUID()
    
    func date() -> Date? {
        let fornatter = ISO8601DateFormatter()
        return fornatter.date(from: publishedAt)
    }
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
}
