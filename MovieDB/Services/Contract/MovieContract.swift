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
    
    func getMovies() async -> Result<PaginatedResponse<Movie>, Error>
}

extension MovieContract {
    
    func getMovies() async -> Result<String, Error> {
        return .failure(MovieContractError.notImplemented)
    }
}
