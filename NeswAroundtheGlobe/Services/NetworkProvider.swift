//
//  NetworkProvider.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 17.10.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

final class NetworkProvider {
    
    func fetchNews(country: String, category: String, page: Int, complition: @escaping ([NewsModel], Int?, Error?) -> Void) {
        let apiKey = "dcf98ee62fa84cb1a032d16c0179e2e2"
        ///199a2fc717d4407f8cf287ba1834e3c6 - catalonia
        ///dcf98ee62fa84cb1a032d16c0179e2e2 - zakh
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country)&category=\(category)&pageSize=10&page=\(page)&apiKey=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    complition([], nil, error)
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(NewsResult.self, from: data)
                DispatchQueue.main.async {
                    complition(result.articles ?? [], result.totalResults, error)
                }
            } catch {
                DispatchQueue.main.async {
                    complition([], nil, error)
                }
            }
        }.resume()
    }
}

//https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=dcf98ee62fa84cb1a032d16c0179e2e2
