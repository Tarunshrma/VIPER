//
//  MovieDetailInterector.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 13/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation

protocol MovieDetailInterectorRequestProtocol {
    func fetchDetails(forMovie id:Double)
}

protocol MovieDetailInterectorResponseProtocol {
    func didRecievedMovieDetails(_ movieDetail:MovieDetailModel)
    func didRecievedError(_ error:Error)
}

class MovieDetailInterector:MovieDetailInterectorRequestProtocol {
    
    var movieService: MovieServiceProtocol!
    var presenter: MovieDetailInterectorResponseProtocol!
    
    internal func fetchDetails(forMovie id: Double) {
        movieService.fetchDetails(forMovie: id) { (movieDetail, error) in
            if (error == nil){
                self.presenter.didRecievedMovieDetails(movieDetail as! MovieDetailModel)
            }else{
                self.presenter.didRecievedError(error!)
            }
        }
    }
    
}
