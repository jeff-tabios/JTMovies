//
//  MoviesListViewModelTests.swift
//  JTMoviesTests
//
//  Created by Jeff Tabios on 25/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import JTMovies

class MoviesListViewModelTests: XCTestCase {
    
    var sut = MovieListViewModel(api: MockAPI())
    
    func test_startAndget1Page() {
        sut.refresh()
        XCTAssertEqual(sut.movieItemViewModels.value.count, 20)
    }
    
    func test_get2Pages() {
        sut.refresh()
        XCTAssertEqual(sut.movieItemViewModels.value.count, 20)
        
        sut.getNextPage()
        XCTAssertEqual(sut.movieItemViewModels.value.count, 40)
    }
    
    func test_get2Pages_thenRefresh() {
        sut.refresh()
        XCTAssertEqual(sut.movieItemViewModels.value.count, 20)
        
        sut.getNextPage()
        XCTAssertEqual(sut.movieItemViewModels.value.count, 40)
        
        sut.refresh()
        XCTAssertEqual(sut.movieItemViewModels.value.count, 20)
    }
    
    func test_processMovies(){
        let movie = MovieItem.init(id: 22, title: "Some test Movie", popularity: 1.2, posterPath: nil)
        
        let mvms = sut.processMovies(movieItems: [movie])
        
        XCTAssertEqual(mvms[0].movieId, movie.id)
        XCTAssertEqual(mvms[0].title, movie.title)
        XCTAssertEqual(mvms[0].popularity, "Popularity: \(movie.popularity.rounded())")
        XCTAssertEqual(mvms[0].posterURL, nil)
        
    }
    
    func test_createMovieViewModel(){
        let movie = MovieItem.init(id: 22, title: "Some test Movie", popularity: 1.2, posterPath: nil)
        
        let mvms = sut.createNewMovieItemVM(movieItem: movie)
        
        XCTAssertEqual(mvms.movieId, movie.id)
        XCTAssertEqual(mvms.title, movie.title)
        XCTAssertEqual(mvms.popularity, "Popularity: \(movie.popularity.rounded())")
        XCTAssertEqual(mvms.posterURL, nil)
        
    }
}
