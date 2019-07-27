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
    
    var sut:MovieDetailViewModel!
    
    override func setUp() {
        sut = MovieDetailViewModel(api: MockAPI())
    }
    
    func test_getMovieDetails(){
        let mid = 123
        
        sut.getMovie(movieId: mid) {
            XCTAssertEqual(self.sut.movie?.id,mid)
            XCTAssertEqual(self.sut.mPoster?.absoluteString, "https://image.tmdb.org/t/p/w185_and_h278_bestv2/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg")
            XCTAssertEqual(self.sut.mTitle, "The Lion King")
            XCTAssertEqual(self.sut.mGenre, "Genre: Adventure, Animation, Family, Drama, Action")
            XCTAssertEqual(self.sut.mLang, "Language: English")
            XCTAssertEqual(self.sut.mSynopsis, "Simba idolises his father, King Mufasa, and takes to heart his own royal destiny. But not everyone in the kingdom celebrates the new cub\'s arrival. Scar, Mufasa\'s brother—and former heir to the throne—has plans of his own. The battle for Pride Rock is ravaged with betrayal, tragedy and drama, ultimately resulting in Simba\'s exile. With help from a curious pair of newfound friends, Simba will have to figure out how to grow up and take back what is rightfully his.")
        }
    }
    
    func test_prepareMovie(){
        let m = Movie.init(genres: [Genre.init(id: 1, name: "Genre1"),
                                    Genre.init(id: 2, name: "Genre2")],
                           id: 65535,
                           overview: "This is some synopsis",
                           posterPath: nil,
                           spokenLanguages: [SpokenLanguage.init(name: "lang1"),
                                             SpokenLanguage.init(name: "lang2")],
                           title: "SomeTitle")
        
        sut.movie = m
        sut.prepareMovie()
        
        XCTAssertEqual(self.sut.movie?.id,65535)
        XCTAssertEqual(self.sut.mPoster, nil)
        XCTAssertEqual(self.sut.mTitle, "SomeTitle")
        XCTAssertEqual(self.sut.mGenre, "Genre: Genre1, Genre2")
        XCTAssertEqual(self.sut.mLang, "Language: lang1, lang2")
        XCTAssertEqual(self.sut.mSynopsis, "This is some synopsis")
    }
    
}
