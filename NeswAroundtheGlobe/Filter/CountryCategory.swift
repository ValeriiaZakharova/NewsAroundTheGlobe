//
//  CountryCategory.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 16.10.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation

enum CountryCategory: String, CaseIterable {
    case emirates
    case ukraine
    case russia
    case argentina
    case austria
    case australia
    case belgium
    case bulgaria
    case brazil
    case canada
    case switzerland
    case china
    case colombia
    case cuba
    case czechia
    case germany
    case egypt
    case france
    case unitedKingdom
    case greece
    case hongKong
    case hungary
    case indonesia
    case ireland
    case unitedStates
    case poland
    
    var title: String {
        switch self {
        case .emirates: return "United Arabic Emirates"
        case .ukraine: return "Ukraine"
        case .russia: return "Russia"
        case .argentina: return "Argentina"
        case .austria: return "Austria"
        case .australia: return "Australia"
        case .belgium: return "Belgium"
        case .bulgaria: return "Bulgaria"
        case .brazil: return "Brazil"
        case .canada: return "Canada"
        case .switzerland: return "Switzerland"
        case .china: return "China"
        case .colombia: return "Colombia"
        case .cuba: return "Cuba"
        case .czechia: return "Czechia"
        case .germany: return "Germany"
        case .egypt: return "Egypt"
        case .france: return "France"
        case .unitedKingdom: return "United Kingdom"
        case .greece: return "Greece"
        case .hongKong: return "Hong Kong"
        case .hungary: return "Hungary"
        case .indonesia: return "Indonesia"
        case .ireland: return "Ireland"
        case .unitedStates: return "United States"
        case .poland: return "Poland"
        }
    }
    
    var requestParametres: String {
        switch self {
        case .emirates: return "ae"
        case .ukraine: return "ua"
        case .russia: return "ru"
        case .argentina: return "ar"
        case .austria: return "at"
        case .australia: return "au"
        case .belgium: return "be"
        case .bulgaria: return "bg"
        case .brazil: return "br"
        case .canada: return "ca"
        case .switzerland: return "ch"
        case .china: return "cn"
        case .colombia: return "co"
        case .cuba: return "cu"
        case .czechia: return "cz"
        case .germany: return "de"
        case .egypt: return "eg"
        case .france: return "fr"
        case .unitedKingdom: return "gb"
        case .greece: return "gr"
        case .hongKong: return "hk"
        case .hungary: return "hu"
        case .indonesia: return "id"
        case .ireland: return "ie"
        case .unitedStates: return "us"
        case .poland: return "pl"
        }
    }
}
