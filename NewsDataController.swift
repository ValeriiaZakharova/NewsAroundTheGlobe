//
//  NewsDataController.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 23.10.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

class NewsDataController {
    
    static let shared = NewsDataController()
    
    var favoriteNews: [NewsModel] = []
    
    init() {}
}
