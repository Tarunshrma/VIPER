//
//  MovieService.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 11/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation
import TSNetworking

public typealias ServiceResponse = (AnyObject?, Error?) -> Void

protocol MovieServiceProtocol{
    func fetchMovies(callbackHandler:@escaping ServiceResponse)
    func fetchDetails(forMovie _id:Double, callbackHandler:@escaping ServiceResponse)
}

class MovieService:MovieServiceProtocol{
    
    func fetchMovies(callbackHandler:@escaping ServiceResponse) {
        do{
            let apiEndPoint = APIEndPoints.Movies
            
            var path:String = Bundle.main.path(forResource: apiEndPoint.rawValue, ofType: "json")!
            path = "file://\(path)"
            
            
            let request = try TSNetworking.sharedInstance.createRequest(fromUrl: path, method: NetworkRequestMethod.GET, data: nil)
            
            _ = try TSNetworking.sharedInstance.fetchJSONData(withRequest: request!) { (data, error) -> Void in
                //If error recieved then sent it in closure and return
                if (error != nil)
                {
                    callbackHandler(nil, error)
                    return
                }
            //else try to parse and return the data
                if let rawData = data {
                    let objMovie = apiEndPoint.getParser(jsonData: rawData).parseData()
                    callbackHandler(objMovie,nil)
                }else{
                    callbackHandler(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"No data recieved!"]))
                }
                
            }
        }catch let error as NSError{
            print("Eror fetching for data")
            callbackHandler(nil, error)
        }
    }
    
    func fetchDetails(forMovie _id:Double, callbackHandler:@escaping ServiceResponse)
    {
        do{
            let apiEndPoint = APIEndPoints.MovieDetails
            
            var path:String = Bundle.main.path(forResource: apiEndPoint.rawValue, ofType: "json")!
            path = "file://\(path)"
            
            
            let request = try TSNetworking.sharedInstance.createRequest(fromUrl: path, method: NetworkRequestMethod.GET, data: nil)
            
            _ = try TSNetworking.sharedInstance.fetchJSONData(withRequest: request!) { (data, error) -> Void in
                //If error recieved then sent it in closure and return
                if (error != nil)
                {
                    callbackHandler(nil, error)
                    return
                }
                //else try to parse and return the data
                if let rawData = data {
                    let objMovie = apiEndPoint.getParser(jsonData: rawData).parseData()
                    callbackHandler(objMovie,nil)
                }else{
                    callbackHandler(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"No data recieved!"]))
                }
                
            }
        }catch let error as NSError{
            print("Eror fetching for data")
            callbackHandler(nil, error)
        }
    }

    
}
