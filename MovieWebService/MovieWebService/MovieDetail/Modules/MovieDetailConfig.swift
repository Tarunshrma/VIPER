//
//  MovieDetailConfig.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 13/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation
class MovieDetailConfig{
    
    static let sharedInstance = MovieDetailConfig()
    
    func configure(_ viewController: MovieDetailViewController) {
        //Injecting dependency in config
        let presenter  =  MovieDetailPresenter()
        let interactor = MovieDetailInterector()
        let service    = MovieService()
        
        //Configure V->P->I flow
        viewController.presenter = presenter
        presenter.interector = interactor
        interactor.movieService = service
        
        //Configre I->P->V reverse flow (weak references)
        interactor.presenter = presenter
        presenter.view = viewController
        
    }
    
}
