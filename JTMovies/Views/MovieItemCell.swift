//
//  MovieItemCell.swift
//  JTMovies
//
//  Created by Jeff Tabios on 25/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class MovieItemCell: UITableViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    var movieItemViewModel: MovieItemViewModel? {
        didSet{
            if let item = self.movieItemViewModel {
                
                if let p = item.posterURL {
                    poster.kf.setImage(with: URL(string: p))
                }else{
                    poster.image = UIImage(named: "noposter")
                }
                
                titleLabel.text = item.title
                popularityLabel.text = "Popularity: \(String(describing: item.popularity?.round()))"
            }
        }
    }
    
    
}
