//
//  ViewController.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 11/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import UIKit

protocol MovieListView: class {
    func displayMovieList(_ movie:[MovieListViewModel]?)
    func displayError(_ error:String)
    
}

class MovieListViewController: BaseViewController,MovieListView {
    
    // MARK:- Member variables
    @IBOutlet weak var table:UITableView!
    
    var presenter: MovieListPresenterProtocol!
    fileprivate var movies:[MovieListViewModel]?
    
    // MARK:- View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.showNetworkActivityIndicator()
        presenter.fetchMovies()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        MovieListConfig.sharedInstance.configure(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- View delegate methods
    internal func displayMovieList(_ movies: [MovieListViewModel]?) {
        self.movies = movies
        
        DispatchQueue.main.async {
            self.hideNetworkActivityIndicator()
            self.table.reloadData()
        }
        if (movies?.count)!>0{
            print("Movie name is \(movies?[0].name)")
        }
    }
    
    internal func displayError(_ error:String)
    {
        print("Error fecthing movie detail with response \(error)")
        DispatchQueue.main.async {
            self.hideNetworkActivityIndicator()
        }
    }

}

// MARK:- TableView data source methods
extension MovieListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MovieTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        
        if let objMovie:MovieListViewModel = self.movies?[indexPath.row]
        {
            cell.movieNameLabel.text = objMovie.name
            cell.movieRatingValueLabel.text = objMovie.rating
            cell.movieReleaseDateLabel.text = objMovie.releaseDate
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard self.movies != nil else{
          return 0
        }
        
        return self.movies!.count
    }
}

// MARK:- TableView data source methods
extension MovieListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let objMovie:MovieListViewModel = self.movies?[indexPath.row]
        {
            self.presenter.navigateToMovieDetailScreen(withData: objMovie)
        }

    }
}


