//
//  Enums.swift
//  TSNetworking
//
//  Created by TARUN SHARMA on 17/12/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation

enum ResponseType {
    case xml
    case json
    case data //Non-cahcable NSdata
    case cachableContentData //Cachable content data
    
    func parseResponse(_ data:AnyObject) throws -> AnyObject?
    {
        var parsedData:AnyObject? = data
        
        switch self{
        case .xml:
            //Pase the xml response
            fatalError("XML Parsing not implemented")
        case .json:
            do{
                parsedData = try JSONSerialization.jsonObject(with: data as! Foundation.Data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject?
                
            }catch let error as NSError {
                throw error
            }
            break
        default:
            parsedData = data
        }
        
        return parsedData;
        
    }
}
