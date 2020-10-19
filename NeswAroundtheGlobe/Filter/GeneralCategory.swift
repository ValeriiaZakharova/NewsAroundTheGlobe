//
//  GeneralCategory.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 16.10.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

enum GeneralCategory: String, CaseIterable {
    
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    
    var title: String {
        switch self {
        case .business: return "Business"
        case .entertainment: return "Entertainment"
        case .general: return "General"
        case .health: return "Health"
        case .science: return "Science"
        case .sports: return "Sports"
        case .technology: return "Technology"
        }
    }
    
    var requestParametres: String{
        switch self {
        case .business: return "business"
        case .entertainment: return "entertainment"
        case .general: return "general"
        case .health: return "health"
        case .science: return "science"
        case .sports: return "sports"
        case .technology: return "technology"
        }
    }
}

