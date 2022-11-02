//
//  ApiContract.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import Foundation

enum HttpMethod: String {
    
    case get = "GET"
}

protocol ApiContract {
    
    var baseUrl: String { get }
    var endpoint: String { get }
    var method: HttpMethod { get }
}

extension ApiContract {
    
    /// Default value for the baseUrl, as all APIs are going to use this route.
    /// For extensibility, this could be overwritten in the future by concrete
    /// implementations.
    var baseUrl: String {
        return "https://api.themoviedb.org/3"
    }
}
