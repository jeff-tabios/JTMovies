//
//  MovieListViewModel.swift
//  JTMovies
//
//  Created by Jeff Tabios on 24/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MovieListViewModel {
    
    private var api:APIProtocol?
    private var lastPageLoaded = 0
    var movieItemViewModels = BehaviorRelay<[MovieItemViewModel]>(value: [])
    
    init(api:APIProtocol){
        self.api = api
    }
    
    func refresh(){
        lastPageLoaded=0
        getNextPage()
    }
    
    func getNextPage(){
        api?.request(endPoint: MovieAPI.getMovies(page: lastPageLoaded+1), completion: { [weak self] (movies:Movies?) in
            guard let movies = movies else { return }
            if let movieVMs = self?.processMovies(movieItems: movies.results){
                self?.lastPageLoaded = movies.page
                self?.movieItemViewModels.accept(movieVMs)
            }
        })
    }
    
    func processMovies(movieItems:[MovieItem])->[MovieItemViewModel]{
        var newItems = [MovieItemViewModel]()
        for movieItem in movieItems{
            newItems.append(createNewMovieItemVM(movieItem: movieItem))
        }
        if lastPageLoaded == 0 {
            return newItems
        }else{
            return movieItemViewModels.value + newItems
        }
    }
    
    func createNewMovieItemVM(movieItem:MovieItem) -> MovieItemViewModel{
        let itemVM = MovieItemViewModel()
        itemVM.movieId = movieItem.id
        if let p = movieItem.posterPath {
            itemVM.posterURL = URL(string: AppConstants.imageBaseUrl + p)
        }
        itemVM.title = movieItem.title
        itemVM.popularity = "Popularity: \(movieItem.popularity.rounded())"
        
        return itemVM
    }
}

class MovieItemViewModel {
    var movieId: Int?
    var posterURL: URL?
    var title: String?
    var popularity: String?
}
