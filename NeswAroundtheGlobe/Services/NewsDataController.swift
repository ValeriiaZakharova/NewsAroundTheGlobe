//
//  NewsDataController.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 23.10.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

final class NewsDataController {
    
    static let shared = NewsDataController()
    
    private let networkProvider = NetworkProvider()
    
    var viewModels: [NewsViewModel] = []
    
    init() {
        
    }
    
    func add(news: NewsViewModel) {
        var newsModel = news
        newsModel.isFavorite = true
        viewModels.append(newsModel)
    }
    
    func remove(news: NewsViewModel) {
        var newsModel = news
        newsModel.isFavorite = false
        guard let index = findNewsIndex(identifier: newsModel.identifier) else { return }
        viewModels.remove(at: index)
    }
    
    func update(news: NewsViewModel) {
        guard let index = findNewsIndex(identifier: news.identifier) else { return }
        viewModels[index] = news
    }
    
    func findNewsIndex(identifier: UUID) -> Int? {
        let newsIndex = viewModels.firstIndex(where: { internalNews -> Bool in
            return internalNews.identifier == identifier
        })
        return newsIndex
    }
    
}

