//
//  Movies.swift
//  JTMovies
//
//  Created by Jeff Tabios on 24/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let page: Int
    let results: [MovieItem]
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}

// MARK: - Result
struct MovieItem: Codable {
    let id: Int
    let title: String
    let popularity: Double
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title, popularity
        case posterPath = "poster_path"
    }
}
