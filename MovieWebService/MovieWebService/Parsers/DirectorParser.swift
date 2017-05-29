//
//  DirectorParser.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 11/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation
class DirectorParser:BaseParser
{
    override func parseData() -> AnyObject? {
        var director:DirectorModel?
        
        guard let responseDict:[String:AnyObject] = self.jsonData as? [String : AnyObject] else
        {
            return nil;
        }
        
        let name = JsonUtility.getStringValue(fromJson: responseDict, forKey: "name")
        let nominated = JsonUtility.getIntValue(fromJson: responseDict, forKey: "nominated")
        let dateOfBirth = JsonUtility.getDoubleValue(fromJson: responseDict, forKey: "dateOfBirth")
        let biography = JsonUtility.getStringValue(fromJson: responseDict, forKey: "biography")
        
        director = DirectorModel()
        director?.name = name
        director?.nominated = nominated
        director?.dateOfBirth = dateOfBirth
        director?.biography = biography
        
        return director as AnyObject?
    }
    
}
