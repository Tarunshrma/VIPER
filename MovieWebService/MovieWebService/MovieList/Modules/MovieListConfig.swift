//
//  MovieListConfig.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 12/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation

class MovieListConfig{
    
    static let sharedInstance = MovieListConfig()
    
    func configure(_ viewController: MovieListViewController) {
       
        //Injecting dependency in config 
        
        let presenter  =  MovieListPresenter()
        let interactor = MovieListInterector()
        let service    = MovieService()
        let router    = MovieListRouter()
        
        //Configure V->P->I flow
        viewController.presenter = presenter
        presenter.interactor = interactor
        interactor.movieService = service
        
        //Configre I->P->V reverse flow (weak references)
        interactor.presenter = presenter
        presenter.view = viewController
        
        //Configure router
        presenter.router = router
        router.viewController = viewController

    }
    
}
