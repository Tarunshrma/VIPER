//
//  MockPresenters.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 14/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation
class MockMovieListPresenter:MovieListInterectorResponseProtocol{
    var movies:[MovieModel]?
    var error:Error?
    
    func didRecievedMovieList(_ movieDetail: [MovieModel]?) {
        self.movies = movieDetail
    }
    
    func didRecievedError(_ error: Error) {
        self.error = error
    }
}


class MockMovieDetailPresenter:MovieDetailInterectorResponseProtocol{
    
    var moviesDetail:MovieDetailModel?
    var error:Error?
    
    func didRecievedMovieDetails(_ movieDetail:MovieDetailModel){
        self.moviesDetail = movieDetail
    }
    
    func didRecievedError(_ error:Error){
        self.error = error
    }
    
 
}
