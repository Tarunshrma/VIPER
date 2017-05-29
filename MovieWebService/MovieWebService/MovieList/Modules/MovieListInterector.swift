//
//  MovieListInterector.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 11/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation

protocol MovieListInterectorRequestProtocol: class {
    func fetchMovies()
}

protocol MovieListInterectorResponseProtocol: class {
    func didRecievedMovieList(_ movieDetail:[MovieModel]?)
    func didRecievedError(_ error:Error)
}


class MovieListInterector:MovieListInterectorRequestProtocol{

    weak var presenter: MovieListInterectorResponseProtocol!
    var movieService: MovieServiceProtocol!
 
    internal func fetchMovies() {
        movieService.fetchMovies { (movies, error) in
            if (error == nil){
               self.presenter.didRecievedMovieList(movies as? [MovieModel])
            }else{
                self.presenter.didRecievedError(error!)
            }
        }
    }

    
}
