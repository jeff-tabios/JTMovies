//
//  MovieDetailViewController.swift
//  JTMovies
//
//  Created by Jeff Tabios on 25/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var mLang: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    
    var movieId: Int?
    
    var vm = MovieDetailViewModel(api: API())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieImage.image = UIImage()
        mTitle.text = ""
        genre.text = ""
        mLang.text = ""
        synopsis.text = ""
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let mid = movieId {
            vm.fetchData(movieId: mid) { [weak self] in
                if let poster = self?.vm.mPoster{
                    self?.movieImage.kf.setImage(with: poster)
                }else{
                    self?.movieImage.image = UIImage(named: "noposter")
                }
                
                self?.mTitle.text = self?.vm.mTitle
                self?.genre.text = self?.vm.mGenre
                self?.mLang.text = self?.vm.mLang
                self?.synopsis.text = self?.vm.mSynopsis
            }
        }
    }
}
