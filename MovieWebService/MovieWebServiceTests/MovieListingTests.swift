//
//  MovieListingTests.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 14/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import XCTest
@testable import MovieWebService

class MovieListingTests: XCTestCase {
    
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
        let viewController = storyboard.instantiateViewController(withIdentifier: MovieListViewControllerIdentifier) as! MovieListViewController
        
        //When
        viewController.loadView()
        
        //Then
        XCTAssert(viewController.table != nil, "Table is not initialized properly")
        
        XCTAssert((viewController.table.delegate?.isEqual(viewController))!, "Table delegate is not initialized properly")
        XCTAssert((viewController.table.dataSource?.isEqual(viewController))!, "Table datasource not initialized properly")
    }
    
    
    func testDisplayMovieListWithMoviesCountMoreThenZero(){
        //Given
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        let viewController = storyboard.instantiateViewController(withIdentifier: MovieListViewControllerIdentifier) as! MovieListViewController
        
        //mock movies data
        let movie1 = MovieListViewModel(withId: 1, name: "Test1")
        let movie2 = MovieListViewModel(withId: 2, name: "Test2")
        
        //When
        viewController.loadView()
        viewController.displayMovieList([movie1,movie2])
        
        //Then
        XCTAssertEqual(viewController.tableView(viewController.table, numberOfRowsInSection: 0), 2,"The number of rows should match the number of movies")
    }

    func testDisplayMovieListWithMoviesCountZero(){
        //Given
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        let viewController = storyboard.instantiateViewController(withIdentifier: MovieListViewControllerIdentifier) as! MovieListViewController
        
        //When
        viewController.loadView()
        viewController.displayMovieList([])
        
        //Then
        XCTAssertEqual(viewController.tableView(viewController.table, numberOfRowsInSection: 0), 0,"The number of rows should match the number of movies")
    }

    // MARK:- Presenter tests
    func testdidRecievedMovieListWithValidMovieDetails(){
        //GIVEN
        let presenter = MovieListPresenter()
        let movie1 = MovieModel(withId: 1, name: "Argo")
        let movie2 = MovieModel(withId: 1, name: "Matrix")
       
        let mockView = MockMovieListView()
        presenter.view = mockView
        //WHEN
        presenter.didRecievedMovieList([movie1,movie2])
        
        //THEN
        XCTAssert(mockView.movies != nil, "Fetch movie set invalid value in presentet")
        XCTAssert(mockView.movies?.count == 2, "Fetch movie set invalid value in presentet")
        XCTAssert(mockView.movies?[0].name == "Argo", "Fetch movie set invalid value in presentet")
    }
    
    func testdidRecievedMovieListWithInValidMovieDetails(){
        //GIVEN
        let presenter = MovieListPresenter()
        
        let mockView = MockMovieListView()
        presenter.view = mockView
        
        //WHEN
        presenter.didRecievedMovieList(nil)
        
        //THEN
        XCTAssert(mockView.errorMessage == "No data recieved", "Should throw proper error message")
    }
    
    // MARK:- Interactor tests
    func testMovieListInterectorFetchMoviesWithValidMovieList(){
        //GIVEN
        //System under test
        let movieListInterector = MovieListInterector()
        
        //Mocking dependencies
        let movieListPresenter = MockMovieListPresenter()
        let movieListService = MockDataService()
        
        movieListInterector.presenter = movieListPresenter
        movieListInterector.movieService = movieListService
        
        //WHEN
        movieListInterector.fetchMovies()
        
        //THEN
        XCTAssert(movieListPresenter.movies?.count == 2, "Fetch movie set invalid value in presentet")
        XCTAssert(movieListPresenter.movies?[1].name == "Matrix", "Fetch movie set invalid value in presentet")
        
    }
    
    func testMovieListInterectorFetchMoviesWithErrorData(){
        //GIVEN
        let movieListInterector = MovieListInterector()
        
        let movieListPresenter = MockMovieListPresenter()
        let movieListService = MockErrorDataService()
        
        movieListInterector.presenter = movieListPresenter
        movieListInterector.movieService = movieListService
        
        //WHEN
        movieListInterector.fetchMovies()
        
        //THEN
        XCTAssert(movieListPresenter.error != nil, "Should set error in presenter")
        XCTAssert(movieListPresenter.error?.localizedDescription == "No data recieved!")
        
    }
    
}
