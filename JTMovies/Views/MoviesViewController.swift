//
//  MoviesViewController.swift
//  JTMovies
//
//  Created by Jeff Tabios on 25/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MoviesViewController: UIViewController{
    
    @IBOutlet weak var moviesTable: UITableView!
    let disposeBag = DisposeBag()
    
    let vm = MovieListViewModel(api: API())
    
    var loadingData = false 
    
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
        vm.refresh()
        refreshControl.endRefreshing()
    }
    
    //MARK: SETUP
    func setup(){
        moviesTable.addSubview(self.refreshControl)
        _ = vm.movieItemViewModels.subscribe(onNext:{_ in
            self.moviesTable.reloadData()
            self.loadingData = false
        }).disposed(by: disposeBag)
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
        return vm.movieItemViewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemCell", for: indexPath) as! MovieItemCell
        cell.movieItemViewModel = vm.movieItemViewModels.value[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = vm.movieItemViewModels.value.count - 1
        if !loadingData && indexPath.row == lastElement {
            vm.fetchMore()
            loadingData = true
        }
    }
}
