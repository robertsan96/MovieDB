//
//  AppEnvironment.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import Foundation

struct AppEnvironment {
    
    let container: Container
}

extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        
        let container = Container(state: appState)
        
        return AppEnvironment(container: container)
    }
    
    private static func configuredApiRepositories() -> Container.ApiRepositories {
        let httpService = Http()
        // TODO: Token should not be hardcoded, find a way to hide it.
        let movieApiRepository = MovieApiRepository(http: httpService, apiToken: "abfabb9de9dc58bb436d38f97ce882bc")
        
        return .init(movieApiRepository: movieApiRepository)
    }
}

extension Container {
    
    struct ApiRepositories {
        let movieApiRepository: MovieApiRepository
    }
}
