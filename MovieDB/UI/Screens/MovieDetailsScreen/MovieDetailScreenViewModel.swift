//
//  MovieDetailScreenViewModel.swift
//  MovieDB
//
//  Created by Robert Sandru on 03.11.2022.
//

import Combine
import UIKit

class MovieDetailScreenViewModel: ObservableObject {
    
    @Published var movie: Movie?
    @Published var moviePoster: UIImage?
    @Published var movieBackdropPath: UIImage?
    @Published var isLoading = false
    
    private var fetchMovieInformationTask: Task<(), Never>?
    private var fetchMoviePhotosTask: Task<(), Never>?
    
    private let movieRepository: MovieContract
    
    // As per requirement: max 2 genres.. And I just built that beautiful
    // scrollable view :( 
    var movieGenres: [MovieGenre] {
        guard let genres =  movie?.genres, genres.count > 1 else { return [] }
        return Array(genres.prefix(upTo: 2))
    }
    
    init(movieId: Int, movieRepository: MovieContract) {
        self.movieRepository = movieRepository
        
        fetchMovieInformation(id: movieId)
    }
    
    convenience init(movieId: Int) {
        let http = Http()
        let movieRepository = MovieApiRepository(http: http, apiToken: Constants.Api.apiKey)
        self.init(movieId: movieId, movieRepository: movieRepository)
    }
    
    deinit {
        fetchMovieInformationTask?.cancel()
        fetchMoviePhotosTask?.cancel()
    }
}

extension MovieDetailScreenViewModel {
    
    private func fetchMovieInformation(id: Int) {
        fetchMovieInformationTask?.cancel()
        fetchMovieInformationTask = Task { [weak self] in
            self?.setIsLoadingOnMainThread(isLoading: true)
            let movieDetailsResult = await self?.movieRepository.getMovieDetails(using: id)
            guard let self = self,
                  let movieDetailsResult = movieDetailsResult else {
                self?.setIsLoadingOnMainThread(isLoading: false)
                return
            }
            DispatchQueue.main.async {
                switch movieDetailsResult {
                case .success(let movie):
                    self.movie = movie
                    // we won't stop the loading yet, we'll
                    // pass it to the next function. We can
                    // experience flickering otherwise, because
                    // isLoading is a Published val
                    self.fetchMoviePhotos(movie: movie)
                case .failure(_):
                    self.isLoading = false
                }
            }
        }
    }
    
    private func setIsLoadingOnMainThread(isLoading: Bool) {
        if Thread.isMainThread { // just in case
            self.isLoading = isLoading
        } else {
            DispatchQueue.main.async {
                self.isLoading = isLoading
            }
        }
    }
    
    /// Will fetch both the backdrop & poster images.
    private func fetchMoviePhotos(movie: Movie) {
        fetchMoviePhotosTask?.cancel()
        fetchMoviePhotosTask = Task { [weak self] in
            guard let self = self,
                  let posterFilename = movie.posterPath,
                  let backdropFilename = movie.backdropPath else {
                    self?.setIsLoadingOnMainThread(isLoading: false)
                return
            }
            async let moviePosterImage = self.movieRepository.getMoviePosterImage(fileName: posterFilename)
            async let movieBackdropImage = self.movieRepository.getMovieBackdropImage(fileName: backdropFilename)
            
            let photosResult = await [moviePosterImage, movieBackdropImage]

            var posterImageOut: UIImage? = nil
            var backdropImageOut: UIImage? = nil
            
            // Poster Image
            switch photosResult[0] {
                case .success(let posterData):
                    guard let posterImage = UIImage(data: posterData) else {
                        return
                    }
                    posterImageOut = posterImage
                default: break
            }
            
            // Backdrop Image
            switch photosResult[1] {
                case .success(let backdropData):
                    guard let backdropImage = UIImage(data: backdropData) else {
                        return
                    }
                    backdropImageOut = backdropImage
                default: break
            }
            
            DispatchQueue.main.async { [posterImageOut, backdropImageOut] in
                self.moviePoster = posterImageOut
                self.movieBackdropPath = backdropImageOut
                self.isLoading = false
            }
        }
    }
}
