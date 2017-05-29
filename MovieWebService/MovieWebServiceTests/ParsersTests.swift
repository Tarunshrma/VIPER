//
//  ParsersTests.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 12/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//


import XCTest

class ParsersTests: XCTestCase {
    
    var mockData:MockMovieData!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.mockData = MockMovieData()
        
        self.continueAfterFailure = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
         self.mockData = nil

        super.tearDown()
    }
   
    // MARK:- Movie parser test methods
    func testMovieParserWithValidResponse()
    {
        //Given
        let rawMovie  = self.mockData.mockMovie!
        let expectedMovieName = rawMovie["name"]
        
        //When
        let movieParser = MovieParser(response:rawMovie as AnyObject!)
        let object = movieParser.parseData()
        
        //Then
        let objMovies = object as? [MovieModel]
        XCTAssert(objMovies != nil,"Parser should return valid movie model")
        XCTAssert(objMovies![0].name == "Argo","Expected movie name is \(expectedMovieName)")
    }
    
    func testMovieParserWithInValidResponse()
    {
        //Given
        let rawInvalidData  = ["Test1":"Value1"]
        
        //When
        let movieParser = MovieParser(response:rawInvalidData as AnyObject!)
        let object = movieParser.parseData()
        
        //Then
        let objMovie = object as? [MovieModel]
        XCTAssert(objMovie == nil,"Movie object should be nil")
    }
    
    // MARK:- Movie Detail parser test methods
    func testMovieDetailParserWithValidResponse()
    {
        //Given
        let rawMovie  = self.mockData.mockMovieDetail!
        let expectedMovieName = rawMovie["name"]
        
        //When
        let movieParser = MovieDetailParser(response:rawMovie as AnyObject!)
        let object = movieParser.parseData()
        
        //Then
        let objMovies = object as? MovieDetailModel
        
        XCTAssert(objMovies != nil,"Parser should return valid movie detail model")
        XCTAssert(objMovies!.name == "Argo","Expected movie name is \(expectedMovieName)")
    }
    
    func testMovieDetailParserWithInValidResponse()
    {
        //Given
        let rawMovie  = ["":""]
        
        //When
        let movieParser = MovieDetailParser(response:rawMovie as AnyObject!)
        let object = movieParser.parseData()
        
        //Then
        let objMovies = object as? MovieDetailModel
        
        XCTAssert(objMovies == nil,"Parser should return valid movie detail model")
    }
    
    // MARK:- Actor parser test methods
    func testActorParserWithValidResponse()
    {
        //Given
        let rawData  = self.mockData.mockActor!
        let expectedActorName = rawData["name"] as! String
        
        //When
        let actorParser = ActorParser(response:rawData as AnyObject!)
        let object = actorParser.parseData()
        
        //Then
        XCTAssert(object is [ActorModel], "Parser should return the valid actor model with valid json response")

        let objActors = object as! [ActorModel]

        XCTAssert(objActors[0].name == expectedActorName,"Expected actor name should be  \(expectedActorName) but showing as \(objActors[0].name)")
    }
    
    func testActorParserWithMultipleActors()
    {
        //Given
        let actor1  = self.mockData.mockActor!
        let actor2  = self.mockData.mockActor!
        let actor3  = self.mockData.mockActor!
        
        let cast = [actor1, actor2, actor3]
        
        let expectedCastCount = cast.count
        
        //When
        let actorParser = ActorParser(response:cast as AnyObject!)
        let object = actorParser.parseData()
        
        //Then
        let objActors = object as! [ActorModel]
        XCTAssert(object is [ActorModel], "Parser should return the array of ActorModel")
        
        XCTAssert(objActors.count == expectedCastCount,"Expected cast count should be  \(expectedCastCount) but showing as \(objActors.count)")
    }

    // MARK:- Director parser test methods
    func testDirectorParserWithValidResponse()
    {
        //Given
        let rawData  = self.mockData.mockDirector!
        let expectedDirectorName = rawData["name"] as! String
        
        //When
        let parser = DirectorParser(response:rawData as AnyObject!)
        let object = parser.parseData()
        
        //Then
        XCTAssert(object is DirectorModel, "Parser should return the valid director model with valid json response")
        
        let objDiractors = object as! DirectorModel
        
        XCTAssert(objDiractors.name == expectedDirectorName,"Expected director name should be  \(expectedDirectorName) but showing as \(objDiractors.name)")
    }
    
    func testDirectorParserWithInValidResponse()
    {
        //Given
        let rawData  = ["":""]
        let expectedDirectorName:String? = nil
        
        //When
        let parser = DirectorParser(response:rawData as AnyObject!)
        let object = parser.parseData()
        
        //Then
        XCTAssert(object is DirectorModel, "Parser should return the valid director model with valid json response")
        
        let objDiractors = object as! DirectorModel
        
        XCTAssert(objDiractors.name == expectedDirectorName,"Expected director name should be  \(expectedDirectorName) but showing as \(objDiractors.name)")
    }
   
}
