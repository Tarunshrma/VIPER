//
//  MovieListPresenter.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 11/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation

protocol MovieListPresenterProtocol:MovieListInterectorResponseProtocol{
    func fetchMovies()
    func navigateToMovieDetailScreen(withData data:MovieListViewModel)
}

class MovieListPresenter:MovieListPresenterProtocol{
    
    weak var view: MovieListView!
    var interactor: MovieListInterectorRequestProtocol!
    var router: MovieListRouterProtocol!
    
    internal func fetchMovies() {
        self.interactor.fetchMovies()
    }

    internal func navigateToMovieDetailScreen(withData data:MovieListViewModel) {
        self.router.navigateToMovieDetailScreen(withData: data)
    }
    
    internal func didRecievedError(_ error: Error) {
        self.view.displayError(error.localizedDescription)
    }

    internal func didRecievedMovieList(_ movieDetail: [MovieModel]?) {
        
        guard let movies = movieDetail else{
            self.view.displayError("No data recieved")
            return
        }
        
        //Convert the service returned data to view model
        let movieListViewData = self.prepareViewModel(from: movies)
        self.view.displayMovieList(movieListViewData!)
    }
    
    
    
    //MARK :- Private methods
    //Convert the business entity to presentable view model
    private func prepareViewModel(from responseData:[MovieModel]?)-> [MovieListViewModel]?
    {
        guard let movies = responseData else{
            return nil
        }
        
        var movieListViewModel = [MovieListViewModel]()
        for movie in movies{
            
            var viewModel = MovieListViewModel(withId: movie.id, name: movie.name)
            
            if let nominated = movie.nominated{
                viewModel.nominated = String(describing: nominated)
            }
            
            if let rating = movie.rating{
                viewModel.rating = String(describing: rating)
            }
            
            if let releaseDate = movie.releaseDate{
                let date = NSDate(timeIntervalSince1970: releaseDate)
                let formattedDate = DateUtility.convertDate(date as Date, toFormat: "MMM dd, YYYY")
                viewModel.releaseDate = formattedDate
            }
            
            movieListViewModel.append(viewModel)
        }
        
        return movieListViewModel
    }

    
}
