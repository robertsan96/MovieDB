//
//  DateFormatter.swift
//  MovieDB
//
//  Created by Robert Sandru on 03.11.2022.
//

import Foundation

extension Date {
    
    static func yearFromServerFormat(_ remoteFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-mm-dd"
        guard let date = dateFormatter.date(from: remoteFormat) else { return "" }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        
        return "\(components.year ?? 0)"
    }
    
    static func yearFromServerFormat(_ remoteFormat: String?) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-mm-dd"
        guard let remoteFormat = remoteFormat,
              let date = dateFormatter.date(from: remoteFormat) else { return Date() }
        
        return date
    }
}
