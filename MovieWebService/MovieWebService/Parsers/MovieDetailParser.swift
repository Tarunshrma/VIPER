//
//  MovieDetailParser.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 13/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation

class MovieDetailParser:BaseParser{
    
    override func parseData() -> AnyObject? {
        
        var movieDetail:MovieDetailModel?
        
        guard let responseDict:[String:AnyObject] = self.jsonData as? [String : AnyObject] else
        {
            return nil;
        }
        
        movieDetail = self.parseItem(responseDict: responseDict)
        
        return movieDetail as AnyObject?
    }
    
    
    private func parseItem(responseDict:[String:AnyObject])->MovieDetailModel?
    {
        var movie:MovieDetailModel?

        let id = JsonUtility.getDoubleValue(fromJson: responseDict, forKey: "id")
        let name = JsonUtility.getStringValue(fromJson: responseDict, forKey: "name")
        
        guard (id != nil && name != nil) else{
            return nil
        }
        
        let rating = JsonUtility.getFloatValue(fromJson: responseDict, forKey: "rating")
        let nominated = JsonUtility.getIntValue(fromJson: responseDict, forKey: "nominated")
        let releaseDate = JsonUtility.getDoubleValue(fromJson: responseDict, forKey: "releaseDate")
        let languages = JsonUtility.getArray(fromJson: responseDict, forKey: "languages") as? [String]

        //Parse the actor model
        var actors:[ActorModel]?
        if let actorsDict:[[String:AnyObject]] = JsonUtility.getDictArray(fromJson: responseDict, forKey: "cast") as [[String:AnyObject]]?
        {
            let actorParser = ActorParser(response: actorsDict as AnyObject!)
            actors = actorParser.parseData() as! [ActorModel]?
        }

        //Parse the director model
        var director:DirectorModel?
        if let directorDict:AnyObject = JsonUtility.getDictionary(fromJson: responseDict, forKey: "director") as AnyObject?
        {
            let directorParser = DirectorParser(response: directorDict)
            director = directorParser.parseData() as! DirectorModel?
        }

        movie = MovieDetailModel(withId: id!, name: name!)
        movie?.actors = actors
        movie?.director = director
        movie?.rating = rating
        movie?.languages  = languages
        movie?.nominated = nominated
        movie?.releaseDate = releaseDate
        
        return movie;
    }

}
