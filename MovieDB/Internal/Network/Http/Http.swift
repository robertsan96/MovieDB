//
//  Http.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import Foundation

fileprivate enum HttpError: Error {
    case invalidUrlFormat
    case invalidParamsFormat
}

/// Concrete implementation of the HttpContract protocol via
/// URL Session.
///
/// Provides REST functionality via **GET**.
final class Http: HttpContract {
    
    func get(url: String, params: [URLQueryItem], headers: [String: String]? = nil) async -> Result<HttpResponse, Error> {
        
        guard var urlComps = URLComponents(string: url) else {
            return .failure(HttpError.invalidUrlFormat)
        }
        urlComps.queryItems = params
        guard let builtUrl = urlComps.url else {
            return .failure(HttpError.invalidParamsFormat)
        }
        let urlRequest = URLRequest(url: builtUrl)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return .success(HttpResponse(data: data))
        } catch let err {
            return .failure(err)
        }
    }
}
