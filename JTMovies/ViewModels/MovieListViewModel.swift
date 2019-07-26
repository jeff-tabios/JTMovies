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
    
    var api:APIProtocol?
    var lastPageLoaded = 0
    var totalPages = 0
    var reloadTableViewClosure: (() -> Void)?
    var movieItemViewModels = BehaviorRelay<[MovieItemViewModel]>(value: [])
    
    init(api:APIProtocol){
        self.api = api
        fetchItems()
    }
    
    func fetchItems(page:Int = 1){
        api?.request(endPoint: MovieAPI.getMovies(page: page), completion: { [weak self] (movies:Movies?) in
            guard let movies = movies,movies.totalResults > 0 else { return }
            self?.lastPageLoaded = movies.page
            self?.totalPages = movies.totalPages
            self?.processMovies(movieItems: movies.results)
        })
    }
    
    func fetchMore(){
        fetchItems(page: lastPageLoaded+1)
    }
    
    func refresh(){
        movieItemViewModels.accept([])
        fetchItems()
    }
    
    func processMovies(movieItems:[MovieItem]){
        var newItems = [MovieItemViewModel]()
        for movieItem in movieItems{
            newItems.append(createNewMovieItemVM(movieItem: movieItem))
        }
        movieItemViewModels.accept(movieItemViewModels.value + newItems)
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
