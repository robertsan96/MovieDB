//
//  PaginatedResponse.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import Foundation

struct PaginatedResponse<T: Codable> {
    
    let page: Int
    let totalPages: Int
    let totalResults: Int
    
    let results: [T]
}
