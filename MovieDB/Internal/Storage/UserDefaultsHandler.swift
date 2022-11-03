//
//  UserDefaultsHandler.swift
//  MovieDB
//
//  Created by Robert Sandru on 03.11.2022.
//

import Foundation

/// This class is a mess, I want to submit the code today so no more decoupling at this point.
class UserDefaultsHandler {
    
    static var shared = UserDefaultsHandler()
    
    let favoriteMoviesKey = "favorite_movies"
    
    private init() { }
    
    func getFavoriteMovieIds() -> [Int] {
        let userDefaults = UserDefaults.standard
        
        return userDefaults.object(forKey: favoriteMoviesKey) as? [Int] ?? []
    }
    
    func setFavoriteMovie(movieId: Int) {
        let userDefaults = UserDefaults.standard
        
        var favoriteMovies = getFavoriteMovieIds()
        favoriteMovies.append(movieId)
        
        userDefaults.set(favoriteMovies, forKey: favoriteMoviesKey)
        userDefaults.synchronize()
    }
    
    func removeFavoriteMovie(movieId: Int) {
        let userDefaults = UserDefaults.standard
        
        let favoriteMovies = getFavoriteMovieIds().filter { $0 != movieId }
        
        userDefaults.set(favoriteMovies, forKey: favoriteMoviesKey)
        userDefaults.synchronize()
    }
}
