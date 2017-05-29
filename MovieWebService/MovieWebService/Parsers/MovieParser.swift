//
//  MovieParser.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 11/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation

class MovieParser:BaseParser
{
    override func parseData() -> AnyObject? {
        
        guard let responseDict = self.jsonData else
        {
            return nil;
        }
        
        var listMovies:[MovieModel]?
        
        if(JsonUtility.isArrayType(fromJson: responseDict as AnyObject)){
            //Enumerate over items and parse it
            if let movies:[[String:AnyObject]] = responseDict as? [[String:AnyObject]]{
                for dict:[String:AnyObject] in movies{
                    if let objMovie = parseItem(responseDict: dict)
                    {
                        if (listMovies == nil)
                        {
                            listMovies = [MovieModel]()
                        }
                        
                        listMovies!.append(objMovie)
                    }
                }
                
            }
        }else if(JsonUtility.isObjectType(fromJson: self.jsonData)){
            //parse it
            if let objMovie = parseItem(responseDict: (self.jsonData as! [String : AnyObject]?)!)
            {
                if (listMovies == nil)
                {
                    listMovies = [MovieModel]()
                }
                
                listMovies!.append(objMovie)
            }
        }
        
        return listMovies as AnyObject?
        
    }
    
    private func parseItem(responseDict:[String:AnyObject])->MovieModel?
    {
        var movie:MovieModel?

        let id = JsonUtility.getDoubleValue(fromJson: responseDict, forKey: "id")
        let name = JsonUtility.getStringValue(fromJson: responseDict, forKey: "name")
        
        guard (id != nil && name != nil) else{
            return nil
        }
        
        let rating = JsonUtility.getFloatValue(fromJson: responseDict, forKey: "rating")
        let nominated = JsonUtility.getIntValue(fromJson: responseDict, forKey: "nominated")
        let releaseDate = JsonUtility.getDoubleValue(fromJson: responseDict, forKey: "releaseDate")

        movie = MovieModel(withId: id!, name: name!)
        movie?.rating = rating
        movie?.nominated = nominated
        movie?.releaseDate = releaseDate
        
        return movie;
    }

    
}
