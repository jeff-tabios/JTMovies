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
        setup()
    }
    
    func setup(){
        vm.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.moviesTable.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieSegue" {
            let s = sender as! MovieItemCell
            let controller = segue.destination as! MovieDetailViewController
            controller.movieId = s.movieId
        }
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate{
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
