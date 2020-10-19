//
//  NetworkProvider.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 17.10.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

final class NetworkProvider {
    
    func fetchNews(country: String, category: String, complition: @escaping ([NewsModel], Error?) -> Void) {
        let apiKey = "dcf98ee62fa84cb1a032d16c0179e2e2"
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country)&category=\(category)&apiKey=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    complition([], error)
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(NewsResult.self, from: data)
                print(result)
                DispatchQueue.main.async {
                    complition(result.articles ?? [], error)
                }
            } catch {
                DispatchQueue.main.async {
                    complition([], error)
                }
            }
        }.resume()
    }
}


//https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=dcf98ee62fa84cb1a032d16c0179e2e2

