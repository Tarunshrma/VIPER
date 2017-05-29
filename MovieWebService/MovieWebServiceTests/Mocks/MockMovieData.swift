//
//  MockMovieData.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 14/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation
struct MockMovieData {
    
    var mockMovie:[String:Any]?
    var mockMovieDetail:[String:Any]?
    var mockActor:[String:AnyObject]?
    var mockDirector:[String:AnyObject]?
    
    init() {
        self.mockMovie = mockMovieData()
        self.mockMovieDetail = mockMovieDetailData()
        self.mockActor = mockActorData()
        self.mockDirector = mockDirectorData()
    }

    
    
    // MARK:- Mock data
    func mockMovieData()->[String:Any]
    {
        var dict = [String:Any]()
        dict["filmRating"] = 3
        dict["nominated"] = 1
        dict["id"] = Double(1)
        dict["name"] = "Argo"
        dict["releaseDate"] = 1350000000
        
        return dict as [String : Any]
    }
    
    
    func mockMovieDetailData()->[String:Any]
    {
        var dict = [String:Any]()
        dict["filmRating"] = 3
        dict["nominated"] = 1
        dict["id"] = Double(1)
        dict["name"] = "Argo"
        dict["languages"] = ["English","Thai"]
        dict["releaseDate"] = 1350000000
        dict["cast"] = mockActorData()
        dict["director"] = mockDirectorData()
        
        return dict as [String : Any]
    }
    
    func mockActorData()->[String:AnyObject]
    {
        var dict = [String:Any]()
        dict["dateOfBirth"] = 436147200
        dict["nominated"] = 1
        dict["name"] = "Bryan Cranston"
        dict["screenName"] = "Jack Donnell"
        dict["biography"] = "Bryan Lee Cranston is an American actor, voice actor, writer and director."
        
        dict["cast"] = dict
        
        return dict as [String : AnyObject]
    }
    
    func mockDirectorData()->[String:AnyObject]
    {
        var dict = [String:Any]()
        dict["dateOfBirth"] = 82684800
        dict["nominated"] = 1
        dict["name"] = "Ben Affleck"
        dict["biography"] = "Benjamin Geza Affleck was born on August 15, 1972 in Berkeley, California, USA but raised in Cambridge, Massachusetts, USA."
        
        dict["director"] = dict
        
        return dict as [String : AnyObject]
        
    }
}
