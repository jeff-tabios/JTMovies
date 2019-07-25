//
//  MovieDetailViewModelTests.swift
//  JTMoviesTests
//
//  Created by Jeff Tabios on 25/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import JTMovies

class MovieDetailViewModelTests: XCTestCase {

    let sut = MovieDetailViewModel(api: API())
    
    func test_getMovieDetails(){
        let mid = 65535
        sut.fetchData(movieId: mid) {
            XCTAssertEqual(self.sut.movie?.id,mid)
            XCTAssertNotEqual(self.sut.mPoster, nil)
            XCTAssertNotEqual(self.sut.mTitle, "")
            XCTAssertNotEqual(self.sut.mGenre, "")
            XCTAssertNotEqual(self.sut.mLang, "")
            XCTAssertNotEqual(self.sut.mSynopsis, "")
        }
    }

}
