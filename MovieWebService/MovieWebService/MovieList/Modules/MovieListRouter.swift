//
//  MovieListRouter.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 13/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation
import UIKit

protocol MovieListRouterProtocol:class {
  func navigateToMovieDetailScreen(withData data:MovieListViewModel)
}

class MovieListRouter:MovieListRouterProtocol{
    
    weak var viewController:MovieListViewController!
    
    internal func navigateToMovieDetailScreen(withData data:MovieListViewModel) {
        let movieDetailVC = movieDetailViewControllerFromStoryboard()
        movieDetailVC.presenter.save(selectedMovie: data)
        viewController.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    func movieDetailViewControllerFromStoryboard() -> MovieDetailViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: MovieDetailViewControllerIdentifier) as! MovieDetailViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }

    
}
