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
    
    let voteAverage: Int?
    let releaseDate: Date?
}
