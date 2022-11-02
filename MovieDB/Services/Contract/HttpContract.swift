//
//  HttpContract.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import Foundation

/// This could be moved to a DTO or Models directory
struct HttpResponse {
    
    var data: Data
}

fileprivate enum HttpContractError: Error {
    case notImplemented
}

/// Contract for REST functionality
/// Not complete! Should provide methods for POST, DELETE, PATCH, PUT etc
/// As for the moment, our API only supports reading through the GET method.
protocol HttpContract {
    
    func get(url: String, params: [URLQueryItem], headers: [String: String]?) async -> Result<HttpResponse, Error>
}

extension HttpContract {
    
    func get() async -> Result<HttpResponse, Error> {
        return .failure(HttpContractError.notImplemented)
    }
}
