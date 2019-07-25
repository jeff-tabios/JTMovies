//
//  MovieDetailViewModel.swift
//  JTMovies
//
//  Created by Jeff Tabios on 25/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

class MovieDetailViewModel{
    
    var movie: Movie? {
        didSet{
            prepareMovie()
        }
    }
    
    var api: APIProtocol?
    
    var mPoster: URL? = nil
    var mTitle: String?
    var mGenre: String? = ""
    var mLang: String? = ""
    var mSynopsis: String?
    
    init(api:APIProtocol){
        self.api = api
    }
    
    func fetchData(movieId:Int,completion: @escaping ()->Void){
        api?.request(endPoint: MovieAPI.getMovie(id:movieId), completion: { [weak self] (movie:Movie?) in
            guard let movie = movie else { return }
            
            self?.movie = movie
            self?.prepareMovie()
            completion()
        })
    }
    
    func prepareMovie(){
        if let movie = movie {
            if let poster = movie.posterPath {
                mPoster = URL(string: AppConstants.imageBaseUrl + poster)
            }
            
            mTitle = movie.title
            
            let g = movie.genres.map{$0.name}.joined(separator: ", ")
            if g != "" { mGenre = "Genre: " + g }
            
            let l = movie.spokenLanguages.map{$0.name}.joined(separator: ", ")
            if l != "" { mLang = "Language: " + l }
            
            mSynopsis   = movie.overview
        }
    }
}
