//Favorites
//  Networking.swift
//  JTMoviesTests
//
//  Created by Jeff Tabios on 24/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import JTMovies

class NetworkingTests: XCTestCase {
    
    let api = API()
    
    func test_get20Movies(){
        api.request(endPoint: MovieAPI.getMovies(page: 1)) { (movies: Movies?) in
            XCTAssertEqual(movies?.results.count, 20)
        }
    }
    
    func test_getNext20Movies(){
        api.request(endPoint: MovieAPI.getMovies(page: 2)) { (movies: Movies?) in
            XCTAssertEqual(movies?.results.count, 20)
        }
    }
    
    func test_getAMovie(){
        api.request(endPoint: MovieAPI.getMovie(id: 328111)) { (movie: Movie?) in
            XCTAssertEqual(movie?.title, "The Secret Life of Pets")
        }
    }
    
}
