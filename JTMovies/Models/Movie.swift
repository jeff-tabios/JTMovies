//
//  Movie.swift
//  JTMovies
//
//  Created by Jeff Tabios on 24/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    
    let genres: [Genre]
    let id: Int
    let overview: String
    let posterPath: String?
    let spokenLanguages: [SpokenLanguage]
    let title: String
    
    enum CodingKeys: String, CodingKey {
        
        case genres, id
        case overview
        case posterPath = "poster_path"
        case spokenLanguages = "spoken_languages"
        case title
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let  name: String
}
