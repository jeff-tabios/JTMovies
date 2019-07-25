//
//  MoviesViewController.swift
//  JTMovies
//
//  Created by Jeff Tabios on 25/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

class MoviesViewController: UIViewController{
    
    @IBOutlet weak var moviesTable: UITableView!
    
    let vm = MovieListViewModel(api: API())
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        moviesTable.register(MovieItemCell.self, forCellReuseIdentifier: "MovieItemCell")
        
        vm.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.moviesTable.reloadData()
            }
        }
    }
}

extension MoviesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.movieItemViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemCell", for: indexPath) as! MovieItemCell
        
        let m=vm.movieItemViewModels[indexPath.row]
        
        cell.movieItemViewModel = m
        
        return cell
        
    }
}
