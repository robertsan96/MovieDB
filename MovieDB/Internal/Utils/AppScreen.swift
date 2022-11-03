//
//  AppScreen.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import Foundation

enum AppScreen {
    case favorites, home, search
    
    var icon: String {
        switch self {
        case .favorites: return "ic_favorites"
        case .home: return "ic_home"
        case .search: return "ic_search"
        }
    }
    
    var iconPress: String {
        switch self {
        case .favorites: return "ic_favorites_press"
        case .home: return "ic_home_press"
        case .search: return "ic_search_press"
        }
    }
    
    var title: String {
        switch self {
        case .favorites: return "Favorites"
        case .home: return "Home"
        case .search: return "Search"
        }
    }
}
