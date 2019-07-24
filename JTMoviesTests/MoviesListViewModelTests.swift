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

    let vm = MovieListViewModel(api: API())
    
    func test_startAndgetMovies() {
        XCTAssertEqual(vm.movieItemViewModels.count, 20)
    }
    
    func test_start_getPage1Movies_getPage2Movies() {
        XCTAssertEqual(vm.movieItemViewModels.count, 20)
        if let lastPage = vm.lastPageLoaded {
            vm.fetchData(page: lastPage + 1)
            XCTAssertEqual(vm.movieItemViewModels.count, 40)
        }
    }
    
    func test_start_getPage1Movies_getPage2Movies_getPage3Movies() {
        XCTAssertEqual(vm.movieItemViewModels.count, 20)
        if let lastPage = vm.lastPageLoaded {
            vm.fetchData(page: lastPage + 1)
            XCTAssertEqual(vm.movieItemViewModels.count, 40)
            if let lastPage = vm.lastPageLoaded {
                vm.fetchData(page: lastPage + 1)
                XCTAssertEqual(vm.movieItemViewModels.count, 60)
            }
        }
    }

}
