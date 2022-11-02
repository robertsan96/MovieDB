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
    private let apiToken: String
    private let decoder: JSONDecoder
    
    init(http: HttpContract, apiToken: String, decoder: JSONDecoder) {
        self.http = http
        self.apiToken = apiToken
        self.decoder = decoder
    }
    
    convenience init(http: HttpContract, apiToken: String) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.init(http: http, apiToken: apiToken, decoder: jsonDecoder)
    }
    
    func getPaginatedNowPlayingMovies() async -> Result<PaginatedResponse<Movie>, Error> {
        await getMovies(api: .getPaginatedNowPlayingMovies)
    }
    
    func getPaginatedPopularMovies() async -> Result<PaginatedResponse<Movie>, Error> {
        await getMovies(api: .getPaginatedPopularMovies)
    }
    
    func getPaginatedTopRatedMovies() async -> Result<PaginatedResponse<Movie>, Error> {
        await getMovies(api: .getPaginatedTopRatedMovies)
    }
    
    func getPaginatedUpcomingMovies() async -> Result<PaginatedResponse<Movie>, Error> {
        await getMovies(api: .getPaginatedUpcomingMovies)
    }
    
    private func getMovies(api: MovieApi) async -> Result<PaginatedResponse<Movie>, Error> {
        let apiTokenQueryParam = URLQueryItem(name: "api_key", value: apiToken)
        let result = await self.http.get(url: api.baseUrl + api.endpoint,
                                         params: [apiTokenQueryParam],
                                         headers: nil)
        switch result {
        case .success(let httpResponse):
            do {
                let decodedData = try decoder.decode(PaginatedResponse<Movie>.self, from: httpResponse.data)
                return .success(decodedData)
            } catch let err {
                return .failure(err)
            }
        case .failure(let err):
            return .failure(err)
        }
    }
}
