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
            
            let favoriteMovies = UserDefaultsHandler.shared.getFavoriteMovieIds()
            let fetchedMovies = await withTaskGroup(of: Movie?.self) { group in
                
                var movies: [Movie] = []
                for favoriteMovie in favoriteMovies {
                    group.addTask {
                        let result = await self.movieRepository.getMovieDetails(using: favoriteMovie)
                        switch result {
                        case .success(let movie): return movie
                        case .failure: return nil
                        }
                    }
                }
                
                for await taskResult in group {
                    if taskResult != nil {
                        movies.append(taskResult!)
                    }
                }
                
                return movies
            }
            DispatchQueue.main.async {
                self.movies = fetchedMovies
            }
        }
    }
}

