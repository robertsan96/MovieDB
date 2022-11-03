//
//  HomeScreenViewModel.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import Foundation
import Combine

@MainActor class HomeScreenViewModel: ObservableObject {
    
    @Published var activeMenuElement: Int = 0
    @Published private(set) var menuElements: [String] = [
        HomeScreenMenuElement.nowPlaying.title,
        HomeScreenMenuElement.popular.title,
        HomeScreenMenuElement.topRated.title,
        HomeScreenMenuElement.upcoming.title
    ]
    @Published private(set) var paginatedResponse: PaginatedResponse<Movie> = .blankPage
    @Published private(set) var isLoading = false
    @Published private(set) var sortStrategy: HomeScreenSortStrategy
    
    var sortedMovies: [Movie] {
        let movies = paginatedResponse.results
        switch sortStrategy {
        case .noSort: return movies
        case .ratingAscending: return movies.sorted { $0.voteAverageOrZero < $1.voteAverageOrZero }
        case .ratingDescending: return movies.sorted { $0.voteAverageOrZero > $1.voteAverageOrZero }
        case .releaseDateAscending:
            return movies.sorted { $0.releaseDateOrNow.compare($1.releaseDateOrNow) == .orderedAscending }
        case .releaseDateDescending:
            return movies.sorted { $0.releaseDateOrNow.compare($1.releaseDateOrNow) == .orderedDescending }
        }
    }
    
    private var cancellables: Set<AnyCancellable> = Set()
    private var fetchMoviesTask: Task<(), Never>?
    
    private let movieRepository: MovieContract
    
    init(movieRepository: MovieContract, sortStrategy: HomeScreenSortStrategy) {
        self.movieRepository = movieRepository
        self.sortStrategy = sortStrategy
        
        initListeners()
    }
    
    convenience init() {
        
        let http = Http()
        let apiToken = Constants.Api.apiKey
        let movieRepository = MovieApiRepository(http: http, apiToken: apiToken)
        let sortStrategy = HomeScreenSortStrategy.noSort
        
        self.init(movieRepository: movieRepository, sortStrategy: sortStrategy)   
    }
    
    deinit {
        fetchMoviesTask?.cancel()
    }
    
    func setSortStrategy(sortStrategy: HomeScreenSortStrategy) {
        self.sortStrategy = sortStrategy
    }
}

// MARK: Listeners
extension HomeScreenViewModel {
    
    func initListeners() {
        listenActiveMenuElementChange()
        listenSortStrategyChange()
    }
    
    func listenActiveMenuElementChange() {
        $activeMenuElement
            .sink { [weak self] activeMenuElement in
                self?.triggerFetchMoviesCall()
            }
            .store(in: &cancellables)
    }
    
    func listenSortStrategyChange() {
        $sortStrategy
            .sink { [weak self] sortStrategy in
                self?.triggerFetchMoviesCall()
            }
            .store(in: &cancellables)
    }
    
    func triggerFetchMoviesCall() {
        fetchMoviesTask?.cancel()
        fetchMoviesTask = Task { [weak self] in
            guard let self = self else { return }
            guard let activeMenuElement = HomeScreenMenuElement(rawValue: self.activeMenuElement) else { return }
            self.isLoading = true
            let result: Result<PaginatedResponse<Movie>, Error>

            switch activeMenuElement {
            case .nowPlaying:
                result = await movieRepository.getPaginatedNowPlayingMovies()
            case .popular:
                result = await movieRepository.getPaginatedPopularMovies()
            case .topRated:
                result = await movieRepository.getPaginatedTopRatedMovies()
            case .upcoming:
                result = await movieRepository.getPaginatedUpcomingMovies()
            }

            switch result {
            case .success(let paginatedResponse):
                self.paginatedResponse = paginatedResponse
            case .failure(let failure):
                self.paginatedResponse = .blankPage
            }
            
            self.isLoading = false
        }
    }
    
    
}

enum HomeScreenMenuElement: Int {
    
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var title: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case .upcoming: return "Upcoming"
        }
    }
}

enum HomeScreenSortStrategy: Int {
    
    case noSort
    
    case ratingAscending
    case ratingDescending
    
    case releaseDateAscending
    case releaseDateDescending
}
