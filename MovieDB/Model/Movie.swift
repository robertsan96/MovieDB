//
//  Movie.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import Foundation

struct Movie: Identifiable, Codable {
    
    let id: Int
    
    let title: String?
    let overview: String?
    let genreIds: [Int]
    
    let backdropPath: String?
    let posterPath: String?
    
    let voteAverage: Double?
    let releaseDate: String?
    
    // Sorting helpers
    var voteAverageOrZero: Double { voteAverage ?? 0 }
    var releaseDateOrNow: Date { Date.yearFromServerFormat(releaseDate) }
}

extension Movie {
    
    static var blank: Movie {
        Movie(id: 0,
              title: "",
              overview: "",
              genreIds: [],
              backdropPath: "",
              posterPath: "",
              voteAverage: 0.0,
              releaseDate: "2022-11-03")
    }
}

#if DEBUG
extension Movie {
    
    static var previews: [Movie] = [
        Movie(id: 123,
              title: "Terrifier",
              overview: "After being resurrected by a sinister entity, Art the Clown returns to Miles County where he must hunt down and destroy a teenage girl and her younger brother on Halloween night.  As the body count rises, the siblings fight to stay alive while uncovering the true nature of Art's evil intent.",
              genreIds: [27, 53],
              backdropPath: "/y5Z0WesTjvn59jP6yo459eUsbli.jpg",
              posterPath: "/wRKHUqYGrp3PO91mZVQ18xlwYzW.jpg",
              voteAverage: 7.2,
              releaseDate: "2022-10-06"),
        Movie(id: 123,
              title: "Terrifier",
              overview: "After being resurrected by a sinister entity, Art the Clown returns to Miles County where he must hunt down and destroy a teenage girl and her younger brother on Halloween night.  As the body count rises, the siblings fight to stay alive while uncovering the true nature of Art's evil intent.",
              genreIds: [27, 53],
              backdropPath: "/y5Z0WesTjvn59jP6yo459eUsbli.jpg",
              posterPath: "/wRKHUqYGrp3PO91mZVQ18xlwYzW.jpg",
              voteAverage: 7.2,
              releaseDate: "2022-10-06"),
        Movie(id: 123,
              title: "Terrifier",
              overview: "After being resurrected by a sinister entity, Art the Clown returns to Miles County where he must hunt down and destroy a teenage girl and her younger brother on Halloween night.  As the body count rises, the siblings fight to stay alive while uncovering the true nature of Art's evil intent.",
              genreIds: [27, 53],
              backdropPath: "/y5Z0WesTjvn59jP6yo459eUsbli.jpg",
              posterPath: "/wRKHUqYGrp3PO91mZVQ18xlwYzW.jpg",
              voteAverage: 7.2,
              releaseDate: "2022-10-06"),
        Movie(id: 123,
              title: "Terrifier",
              overview: "After being resurrected by a sinister entity, Art the Clown returns to Miles County where he must hunt down and destroy a teenage girl and her younger brother on Halloween night.  As the body count rises, the siblings fight to stay alive while uncovering the true nature of Art's evil intent.",
              genreIds: [27, 53],
              backdropPath: "/y5Z0WesTjvn59jP6yo459eUsbli.jpg",
              posterPath: "/wRKHUqYGrp3PO91mZVQ18xlwYzW.jpg",
              voteAverage: 7.2,
              releaseDate: "2022-10-06")
    ]
}
#endif

