//
//  MovieApi.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import Foundation

enum MovieApi: ApiContract {
    
    case getPaginatedNowPlayingMovies
    case getPaginatedPopularMovies
    case getPaginatedTopRatedMovies
    case getPaginatedUpcomingMovies
    
    var endpoint: String {
        let baseEndpoint = "/movie"
        switch self {
        case .getPaginatedNowPlayingMovies: return baseEndpoint + "/now_playing"
        case .getPaginatedPopularMovies: return baseEndpoint + "/popular"
        case .getPaginatedTopRatedMovies: return baseEndpoint + "/top_rated"
        case .getPaginatedUpcomingMovies: return baseEndpoint + "/upcoming"
        }
    }
    
    var method: HttpMethod {
        return .get // we are using a read only API, so no other methods are required
    }
}
