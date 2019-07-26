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
    
    //MARK: Refresh
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl){
        vm.movieItemViewModels = []
        vm.fetchData()
        refreshControl.endRefreshing()
    }
    
    //MARK: SETUP
    func setup(){
        moviesTable.addSubview(self.refreshControl)
        
        vm.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.moviesTable.reloadData()
            }
        }
    }
    
    //MARK: SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieSegue" {
            let s = sender as! MovieItemCell
            let controller = segue.destination as! MovieDetailViewController
            controller.movieId = s.movieId
        }
    }
}

//MARK: Table data soure and delegate
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
