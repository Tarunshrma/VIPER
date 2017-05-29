//
//  MockDataService.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 14/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation
class MockDataService:MovieServiceProtocol{
    
    func fetchMovies(callbackHandler:@escaping ServiceResponse){
        let movie1 = MovieModel(withId: 1, name: "Argo")
        let movie2 = MovieModel(withId: 2, name: "Matrix")
        callbackHandler([movie1,movie2] as AnyObject?,nil)
    }
    
    func fetchDetails(forMovie _id:Double, callbackHandler:@escaping ServiceResponse){
        let movieDetail = MovieDetailModel(withId: 1, name: "Argo")
        callbackHandler(movieDetail as AnyObject?,nil)
    }
}

class MockErrorDataService:MovieServiceProtocol{
    
    func fetchMovies(callbackHandler:@escaping ServiceResponse){
        callbackHandler(nil,NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"No data recieved!"]))
    }
    
    func fetchDetails(forMovie _id:Double, callbackHandler:@escaping ServiceResponse){
        callbackHandler(nil,NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"No data recieved!"]))
    }
}
