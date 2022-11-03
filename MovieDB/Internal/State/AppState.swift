//
//  AppState.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import Foundation

struct AppState {

    var movies: [Movie] = []
}

extension AppState: Equatable {

    static func == (lhs: AppState, rhs: AppState) -> Bool {
        lhs.movies.count == rhs.movies.count
    }
}

#if DEBUG
extension AppState {
    
    static var preview: Self {
        .init(movies: [])
    }
}
#endif
