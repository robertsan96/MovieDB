//
//  FavoriteScreenViewModel.swift
//  MovieDB
//
//  Created by Robert Sandru on 03.11.2022.
//

import Foundation
import Combine

class FavoriteScreenViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var searchKeyword: String = ""
    
    private let movieRepository: MovieContract
    
    private var cancellables: Set<AnyCancellable> = Set()
    private var fetchMoviesTask: Task<(), Never>?
    
    var filteredMovies: [Movie] {
        return movies.filter { movie in
            UserDefaultsHandler.shared.getFavoriteMovieIds().first {
                $0 == movie.id
            } != nil
        }
    }
    
    init(movieRepository: MovieContract) {
        self.movieRepository = movieRepository
        
        triggerFetchMoviesCall()
    }
    
    convenience init() {
        let http = Http()
        let movieRepository = MovieApiRepository(http: http, apiToken: Constants.Api.apiKey)
        
        self.init(movieRepository: movieRepository)
    }
    
    deinit {
        fetchMoviesTask?.cancel()
    }
}

// MARK: Listeners & Network
extension FavoriteScreenViewModel {
    
    func triggerFetchMoviesCall() {
        fetchMoviesTask?.cancel()
        fetchMoviesTask = Task { [weak self] in
            guard let self = self else { return }
            let result = await self.movieRepository.getPaginatedPopularMovies()

            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.movies = movies.results
                }
            case .failure(let err):
                print(err)
            }
        }
    }
}

