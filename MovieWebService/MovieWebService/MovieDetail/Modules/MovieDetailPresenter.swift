//
//  MovieDetailPresenter.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 13/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation
//
protocol MovieDetailPresenterProtocol:MovieDetailInterectorResponseProtocol{
    func fetchMovieDetails()
    func save(selectedMovie _selectedMovie:MovieListViewModel)
}

class MovieDetailPresenter:MovieDetailPresenterProtocol{

    weak var view: MovieDetailViewProtocol!
    var interector:MovieDetailInterectorRequestProtocol!
    var selectedMovie:MovieListViewModel!
    
    func save(selectedMovie _selectedMovie:MovieListViewModel)
    {
        selectedMovie = _selectedMovie;
    }
    
    internal func fetchMovieDetails() {
        self.interector.fetchDetails(forMovie: self.selectedMovie.id)
    }
    
    internal func didRecievedError(_ error: Error) {
        self.view.displayError(error.localizedDescription)
    }

    internal func didRecievedMovieDetails(_ movieDetail:MovieDetailModel) {
        let viewModel = self.prepareViewModel(from: movieDetail)
        
        if let objMovieDetail = viewModel {
            self.view.displayMovieDetail(objMovieDetail)
        }else
        {
            //No valid data, display as error
            self.view.displayError("No valid data present to display")
        }
       
    }
    
    
    //MARK :- Private methods
    //Convert the business entity to presentable view model
    private func prepareViewModel(from responseData:MovieDetailModel?)-> MovieDetailViewModel?
    {
        guard let moviesDetail = responseData else{
            return nil
        }
        
        let movieName:String? = moviesDetail.name
        let actorName:String? = moviesDetail.actors?[0].name
        let actorScreenName:String? =  moviesDetail.actors?[0].screenName
        let directorName:String? = moviesDetail.director?.name
        
        guard (movieName != nil && actorName != nil && directorName != nil) else
        {
            return nil
        }
        
        var movieDetailViewModel = MovieDetailViewModel(movieName!, actorName: actorName!, directorName: directorName!)
        movieDetailViewModel.actorScreenName = actorScreenName
        
        return movieDetailViewModel
    }

    
}
