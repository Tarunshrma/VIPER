//
//  MovieDetailTests.swift
//  MovieWebService
//
//  Created by Tarun Sharma on 3/15/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import XCTest

class MovieDetailTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
     // MARK:- ViewController tests
    func testOutletsConnections()
    {
        //Given
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        let viewController = storyboard.instantiateViewController(withIdentifier: MovieDetailViewControllerIdentifier) as! MovieDetailViewController
        
        //When
        viewController.loadView()
        
        //Then
        let outletsStatus = (viewController.actorNameLabel == nil || viewController.actorScreenNameLabel == nil || viewController.directorNameLabel == nil || viewController.actorDetailView == nil)
        
        XCTAssertFalse(outletsStatus, "Outlets are not initialized properly")
        
    }
    
    func testShowDetailButtonTappedEvent(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        let viewController = storyboard.instantiateViewController(withIdentifier: MovieDetailViewControllerIdentifier) as! MovieDetailViewController
        let mockButton = UIButton()
        
        //When
        viewController.loadView()
        viewController.showDetailButtonTapped(mockButton)
        
        //Then
        XCTAssert(mockButton.isHidden, "Button should be hidden")
        XCTAssertFalse(viewController.actorDetailView.isHidden,"Detail view should be visible")
        
    }

    
     // MARK:- Presenter tests
    
    
    // MARK:- Interecter tests
    func testMovieDetailInterectorFetchDetailWithValidMovieData(){
        //GIVEN
        //System under test
        let movieDetailInterector = MovieDetailInterector()
        
        //Mocking dependencies
        let movieDetailPresenter = MockMovieDetailPresenter()
        let movieService = MockDataService()
        
        movieDetailInterector.presenter = movieDetailPresenter
        movieDetailInterector.movieService = movieService
        
        //WHEN
        movieDetailInterector.fetchDetails(forMovie: 1)
        
        //THEN
        XCTAssert(movieDetailPresenter.moviesDetail != nil, "Movie detail should be fetched")
        XCTAssert(movieDetailPresenter.moviesDetail?.name == "Argo", "Fetch movie detail is not correct")
        
    }
    
    func testMovieDetailInterectorFetchDetailWithInValidMovieData(){
        //GIVEN
        let movieDetailInterector = MovieDetailInterector()
        
        let movieDetailPresenter = MockMovieDetailPresenter()
        let movieService = MockErrorDataService()
        
        movieDetailInterector.presenter = movieDetailPresenter
        movieDetailInterector.movieService = movieService
        
        //WHEN
        movieDetailInterector.fetchDetails(forMovie: 1)
        
        //THEN
        XCTAssert(movieDetailPresenter.error != nil, "Should set error in presenter")
        XCTAssert(movieDetailPresenter.error?.localizedDescription == "No data recieved!")
        
    }

    
}
