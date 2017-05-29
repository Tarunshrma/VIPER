//
//  ActorParser.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 11/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//


import Foundation
class ActorParser:BaseParser
{
    override func parseData() -> AnyObject? {
        
        var listActors = [ActorModel]()
        
        if(JsonUtility.isArrayType(fromJson: self.jsonData)){
            //Enumerate over items and parse it
            if let actors:[[String:AnyObject]] = self.jsonData as? [[String:AnyObject]]{
                    for dict:[String:AnyObject] in actors{
                        if let objActor = parseItem(jsoDict: dict)
                        {
                            listActors.append(objActor)
                        }
                }
                
            }
        }else if(JsonUtility.isObjectType(fromJson: self.jsonData)){
            //parse it
            if let objActor = parseItem(jsoDict: self.jsonData as! [String : AnyObject]?)
            {
                listActors.append(objActor)
            }
        }
        
        return listActors as AnyObject?
        
    }
    
    private func parseItem(jsoDict:[String:AnyObject]?)->ActorModel?
    {
        var actor:ActorModel?
        
        guard let responseDict = jsoDict else
        {
            return nil;
        }
        
        if (JsonUtility.isObjectType(fromJson: jsoDict as AnyObject))
        {
            let name = JsonUtility.getStringValue(fromJson: responseDict, forKey: "name")
            let screenName = JsonUtility.getStringValue(fromJson: responseDict, forKey: "screenName")
            let nominated = JsonUtility.getIntValue(fromJson: responseDict, forKey: "nominated")
            let dateOfBirth = JsonUtility.getDoubleValue(fromJson: responseDict, forKey: "dateOfBirth")
            let biography = JsonUtility.getStringValue(fromJson: responseDict, forKey: "biography")
            
            actor = ActorModel()
            actor?.name = name
            actor?.screenName = screenName
            actor?.nominated = nominated
            actor?.dateOfBirth = dateOfBirth
            actor?.biography = biography
        }
        
        return actor
    }
}
