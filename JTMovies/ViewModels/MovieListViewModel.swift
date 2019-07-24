//
//  MovieListViewModel.swift
//  JTMovies
//
//  Created by Jeff Tabios on 24/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

class MovieListViewModel {
    
    var api:APIProtocol?
    var lastPageLoaded: Int?
    var totalPages: Int?
    var reloadTableViewClosure: (() -> Void)?
    
    var movieItemViewModels = [MovieItemViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    init(api:APIProtocol){
        self.api = api
        fetchData()
    }
    
    func fetchData(page:Int = 1){
        api?.request(endPoint: MovieAPI.getMovies(page: page), completion: { [weak self] (movies:Movies?) in
            guard let movies = movies,movies.totalResults > 0 else { return }
            self?.lastPageLoaded = movies.page
            self?.totalPages = movies.totalPages
            self?.processMovies(movieItems: movies.results)
        })
    }
    
    func processMovies(movieItems:[MovieItem]){
        var newItems = [MovieItemViewModel]()
        for movieItem in movieItems{
            newItems.append(createNewMovieItemVM(movieItem: movieItem))
        }
        movieItemViewModels += newItems
    }
    
    func createNewMovieItemVM(movieItem:MovieItem) -> MovieItemViewModel{
        let itemVM = MovieItemViewModel()
        if let poster = movieItem.posterPath {
            itemVM.poster = UIImage(named: poster)
        }else{
            itemVM.poster = UIImage()
        }
        itemVM.title = movieItem.title
        itemVM.popularity = movieItem.popularity
        return itemVM
    }
    
}

class MovieItemViewModel {
    var poster: UIImage?
    var title: String?
    var popularity: Double?
}
