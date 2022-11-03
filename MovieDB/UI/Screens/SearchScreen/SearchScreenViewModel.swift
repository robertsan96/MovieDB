//
//  SearchScreenViewModel.swift
//  MovieDB
//
//  Created by Robert Sandru on 03.11.2022.
//

import Foundation
import Combine

class SearchScreenViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var searchKeyword: String = ""
    
    private let movieRepository: MovieContract
    private var cancellables: Set<AnyCancellable> = Set()
    private var fetchMoviesTask: Task<(), Never>?
    
    init(movieRepository: MovieContract) {
        self.movieRepository = movieRepository
        
        initListeners()
    }
    
    convenience init() {
        let http = Http()
        let movieRepository = MovieApiRepository(http: http, apiToken: Constants.Api.apiKey)
        
        self.init(movieRepository: movieRepository)
    }
    
    deinit {
        fetchMoviesTask?.cancel()
    }
    
    func setSearchKeyword(_ keyword: String) {
        self.searchKeyword = keyword
    }
}

// MARK: Listeners & Network
extension SearchScreenViewModel {
    
    func initListeners() {
        listenSearchKeywordChanges()
    }
    
    func listenSearchKeywordChanges() {
        $searchKeyword
            .sink { [weak self] searchKeyword in
                self?.triggerFetchMoviesCall()
            }
            .store(in: &cancellables)
    }
    
    func triggerFetchMoviesCall() {
        fetchMoviesTask?.cancel()
        fetchMoviesTask = Task { [weak self] in
            guard let self = self else { return }
            let result: Result<PaginatedResponse<Movie>, Error>
            if self.searchKeyword.count > 0 {
                result = await self.movieRepository.searchMovies(query: self.searchKeyword)
            } else {
                result = await self.movieRepository.getPaginatedPopularMovies() // fallback.. hate voids
            }
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

