//
//  MockViews.swift
//  MovieWebService
//
//  Created by Tarun Sharma on 3/15/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation

class MockMovieListView:MovieListView{
    
    var movies:[MovieListViewModel]?
    var errorMessage:String?
    
    func displayMovieList(_ movie:[MovieListViewModel]?)
    {
        self.movies = movie
    }
    
    func displayError(_ error:String){
        self.errorMessage = error
    }
}
