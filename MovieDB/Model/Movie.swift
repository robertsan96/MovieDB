//
//  Movie.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import Foundation

struct Movie: Identifiable, Codable {
    
    let id: Int
    
    let title: String?
    let overview: String?
    let genreIds: [Int]
    
    let backdropPath: String?
    let posterPath: String?
    
    let voteAverage: Double?
    let releaseDate: String?
}

extension Movie {
    
    static var blank: Movie {
        Movie(id: 0,
              title: "",
              overview: "",
              genreIds: [],
              backdropPath: "",
              posterPath: "",
              voteAverage: 0.0,
              releaseDate: "2022-11-03")
    }
}

