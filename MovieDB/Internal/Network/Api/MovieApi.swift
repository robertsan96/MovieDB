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
    
    case getMovieDetails(id: Int)
    case getPosterImage
    case getBackdropImage
    
    var endpoint: String {
        let baseMovieEndpoint = "/movie"
        switch self {
        case .getPaginatedNowPlayingMovies: return baseMovieEndpoint + "/now_playing"
        case .getPaginatedPopularMovies: return baseMovieEndpoint + "/popular"
        case .getPaginatedTopRatedMovies: return baseMovieEndpoint + "/top_rated"
        case .getPaginatedUpcomingMovies: return baseMovieEndpoint + "/upcoming"
        
        case .getMovieDetails(let id): return baseMovieEndpoint + "/\(String(id))"
        case .getPosterImage: return "/t/p/w500" // TODO: Support different sizes
        case .getBackdropImage: return "/t/p/w500" // TODO: Support different sizes
        }
    }
    
    var method: HttpMethod {
        return .get // we are using a read only API, so no other methods are required
    }
    
    var baseUrl: String {
        switch self {
        case .getPosterImage,
             .getBackdropImage: return "https://image.tmdb.org"
        default: return "https://api.themoviedb.org/3"
        }
    }
}
