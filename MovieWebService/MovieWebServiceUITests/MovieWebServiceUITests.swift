//
//  MovieWebServiceUITests.swift
//  MovieWebServiceUITests
//
//  Created by TARUN SHARMA on 11/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import XCTest
@testable import MovieWebService

class MovieWebServiceUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieListNavigation()
    {
        
        let app = XCUIApplication()
        
        //Fetch the loadign indicator
        let loadingIndicator = app.activityIndicators["LoadingIndicator"]
        
        //Wait till loading indicator visible
        let exists = NSPredicate(format: "exists == 0")
        self.expectation(for: exists, evaluatedWith: loadingIndicator, handler: nil)
        self.waitForExpectations(timeout: 5.0, handler: nil)
        
        let table = app.descendants(matching: .table)
        
        //Assert failure if no data found
        XCTAssert(table.cells.count > 0, "No data found for movie listing")
        
        //Tap on first row of table
        let firstCell = table.cells.element(boundBy: 0)
        firstCell.tap();
        
        //Assert failure if movie detail screen not pushed
        XCTAssertEqual(app.navigationBars.element.identifier, "Movie Details")
        
        self.expectation(for: exists, evaluatedWith: loadingIndicator, handler: nil)
        self.waitForExpectations(timeout: 5.0, handler: nil)
        
        let actorLabel = app.staticTexts["ActorName"]
        let actorScreenNameLabel = app.staticTexts["ActorScreenName"]

        //Assert failure if initially actor name and screen name visible
        XCTAssertFalse(actorLabel.exists)
        XCTAssertFalse(actorScreenNameLabel.exists)
        
        //Assert failure if director name is not visible on screen
        let directorLabel = app.staticTexts["DirectorName"]
        XCTAssert(directorLabel.exists)
        
        //Tap on show more button
        app.buttons["ShowMore"].tap()
        
        //Now assert failure if actor name and screen name is not visible on screen
        XCTAssert(actorLabel.exists)
        XCTAssert(actorScreenNameLabel.exists)

        
    }
    
}
