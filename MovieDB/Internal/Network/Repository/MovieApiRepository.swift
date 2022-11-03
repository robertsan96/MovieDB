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
    
    private var apiTokenQueryParam: URLQueryItem { .init(name: "api_key", value: apiToken) }
    
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
    
    func getMovieDetails(using id: Int) async -> Result<Movie, Error> {
        let api = MovieApi.getMovieDetails(id: id)
        let result = await self.http.get(url: api.baseUrl + api.endpoint,
                                         params: [apiTokenQueryParam],
                                         headers: nil)
        switch result {
        case .success(let httpResponse):
            do {
                let decodedData = try decoder.decode(Movie.self, from: httpResponse.data)
                return .success(decodedData)
            } catch let err {
                print(err)
                return .failure(err)
            }
        case .failure(let err):
            return .failure(err)
        }
    }
    
    func getMoviePosterImage(fileName: String) async -> Result<Data, Error> {
        let api = MovieApi.getPosterImage
        let result = await self.http.get(url: api.baseUrl + api.endpoint + fileName,
                                         params: [apiTokenQueryParam],
                                         headers: nil)
        switch result {
        case .success(let httpResponse):
            return .success(httpResponse.data)
        case .failure(let err):
            return .failure(err)
        }
    }

    /// Same logic as poster image fetching, duplicating with separation of concerns in mind...
    func getMovieBackdropImage(fileName: String) async -> Result<Data, Error> {
        let api = MovieApi.getBackdropImage
        let result = await self.http.get(url: api.baseUrl + api.endpoint + fileName,
                                         params: [apiTokenQueryParam],
                                         headers: nil)
        switch result {
        case .success(let httpResponse):
            return .success(httpResponse.data)
        case .failure(let err):
            return .failure(err)
        }
    }
    
}
