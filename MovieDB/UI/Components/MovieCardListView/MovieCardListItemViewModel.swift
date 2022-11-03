//
//  MovieCardListItemViewModel.swift
//  MovieDB
//
//  Created by Robert Sandru on 03.11.2022.
//

import Foundation
import UIKit
import Combine

class MovieCardListItemViewModel: ObservableObject {
    
    @Published var movie: Movie
    @Published var posterImage: UIImage?
    
    var releaseYear: String { Date.yearFromServerFormat(movie.releaseDate ?? "") }
    var voteAverage: String { String(movie.voteAverage ?? 0) }
    
    private var fetchPosterImageTask: Task<(), Never>?
    private var cancellables: Set<AnyCancellable> = Set()
    private let movieRepository: MovieContract
    
    init(movie: Movie, movieRepository: MovieContract) {
        self.movie = movie
        self.movieRepository = movieRepository
        
        initListeners()
    }
    
    convenience init(movie: Movie) {
        let http = Http()
        let movieRepository = MovieApiRepository(http: http, apiToken: "abfabb9de9dc58bb436d38f97ce882bc")
        
        self.init(movie: movie, movieRepository: movieRepository)
    }
    
    deinit {
        fetchPosterImageTask?.cancel()
    }
}

// MARK: Listeners
extension MovieCardListItemViewModel {
    
    private func initListeners() {
        $movie.sink { [weak self] movie in
            self?.triggerFetchMoviePosterCall()
        }
        .store(in: &cancellables)
    }
    
    private func triggerFetchMoviePosterCall() {
        fetchPosterImageTask?.cancel()
        fetchPosterImageTask = Task { [weak self] in
            guard let self = self,
                  let posterPath = movie.posterPath else { return }
            
            let result = await movieRepository.getMoviePosterImage(fileName: posterPath)
            
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.posterImage = image
                }
            case .failure: break
                //
            }
            
        }
    }
}
