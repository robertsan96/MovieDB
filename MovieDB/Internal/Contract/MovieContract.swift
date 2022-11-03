//
//  MovieContract.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import Foundation

fileprivate enum MovieContractError: Error {
    case notImplemented
}

protocol MovieContract {
    
    func getPaginatedNowPlayingMovies() async -> Result<PaginatedResponse<Movie>, Error>
    func getPaginatedPopularMovies() async -> Result<PaginatedResponse<Movie>, Error>
    func getPaginatedTopRatedMovies() async -> Result<PaginatedResponse<Movie>, Error>
    func getPaginatedUpcomingMovies() async -> Result<PaginatedResponse<Movie>, Error>
    
    func getMovieDetails(using id: Int) async -> Result<Movie, Error>
    func getMoviePosterImage(fileName: String) async -> Result<Data, Error>
    func getMovieBackdropImage(fileName: String) async -> Result<Data, Error>
    
    func searchMovies(query: String) async -> Result<PaginatedResponse<Movie>, Error>
}

extension MovieContract {
    
    func getPaginatedNowPlayingMovies() async -> Result<PaginatedResponse<Movie>, Error> {
        return .failure(MovieContractError.notImplemented)
    }
    
    func getPaginatedPopularMovies() async -> Result<PaginatedResponse<Movie>, Error> {
        return .failure(MovieContractError.notImplemented)
    }
    
    func getPaginatedTopRatedMovies() async -> Result<PaginatedResponse<Movie>, Error> {
        return .failure(MovieContractError.notImplemented)
    }
    
    func getPaginatedUpcomingMovies() async -> Result<PaginatedResponse<Movie>, Error> {
        return .failure(MovieContractError.notImplemented)
    }
    
    func getMoviePosterImage(fileName: String) async -> Result<Data, Error> {
        return .failure(MovieContractError.notImplemented)
    }
    
    func getMovieBackdropImage(fileName: String) async -> Result<Data, Error> {
        return .failure(MovieContractError.notImplemented)
    }
    
    func getMovieDetails(using id: Int) async -> Result<Data, Error> {
        return .failure(MovieContractError.notImplemented)
    }
    
    func searchMovies(query: String) async -> Result<PaginatedResponse<Movie>, Error> {
        return .failure(MovieContractError.notImplemented)
    }
}
