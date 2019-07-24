//
//  MovieAPI.swift
//  JTMovies
//
//  Created by Jeff Tabios on 24/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

enum MovieAPI {
    case getMovie(id:Int)
    case getMovies(page:Int)
}

extension MovieAPI: EndPoint {
    var apiKey: String { return "328c283cd27bd1877d9080ccb1604c91" }
    var sortBy: String { return "release_date.desc" }
    
    var baseURL: String {
        return "http://api.themoviedb.org/3"
    }
    
    var path: String {
        switch self {
        case .getMovie(let id):
            return "/movie/\(id)"
        case .getMovies:
            return "/discover/movie"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders {
        return [:]
    }
    
    var params: Parameters {
        var items = Parameters()
        items["api_key"]=apiKey
        
        switch self {
        case .getMovie:
            break
        case .getMovies(let page):
            items["page"]="\(page)"
            items["sort_by"]=sortBy
        }
        return items
    }
    
    
}
