//
//  NewsResult.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 16.10.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

struct NewsResult: Decodable {
    var status: String
    var totalResults: Int
    var articles: [NewsModel]?
}
