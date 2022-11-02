//
//  MovieApiRepository.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import Foundation

fileprivate enum MovieApiRepositoryError: Error {
    
    case couldNotFetchMovies
}

final class MovieApiRepository: MovieContract {
    
    private let http: HttpContract
    
    init(http: HttpContract) {
        self.http = http
    }
    
    func getMovies() async -> Result<PaginatedResponse<Movie>, Error> {
        let result = await self.http.get(url: <#T##String#>,
                                         params: <#T##[URLQueryItem]#>,
                                         headers: <#T##[String : String]?#>)
        return .failure(MovieApiRepositoryError.couldNotFetchMovies)
    }
}
