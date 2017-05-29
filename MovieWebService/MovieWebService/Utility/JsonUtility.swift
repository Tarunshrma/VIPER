//
//  JsonUtility.swift
//  NetworkCalls
//
//  Created by Tarun Sharma on 5/9/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation

class JsonUtility{
    //TODO: Can ues Generics
    static func getStringValue(fromJson json:[String:AnyObject], forKey key:String)-> String?{
        guard let value  = json[key] else {
            return nil;
        }
        
        return value as? String;
    }
    
    static func getIntValue(fromJson json:[String:AnyObject], forKey key:String)-> Int?{
        guard let value:Int  = json[key] as? Int else {
            return nil;
        }
        
        return value;
    }
    
    static func getDoubleValue(fromJson json:[String:AnyObject], forKey key:String)-> Double?{
        guard let value:Double  = json[key] as? Double else {
            return nil;
        }
        
        return value;
    }

    static func getFloatValue(fromJson json:[String:AnyObject], forKey key:String)-> Float?{
        guard let value:Float  = json[key] as? Float else {
            return nil;
        }
        
        return value;
    }

    
    static func getDictionary(fromJson json:[String:AnyObject], forKey key:String)-> [String:AnyObject]?{
        guard let value  = json[key] as? [String:AnyObject] else {
            return nil;
        }
        
        return value;
    }
    
    static func getDictArray(fromJson json:[String:AnyObject], forKey key:String)-> [[String:AnyObject]]?{
        guard let value  = json[key] as? [[String:AnyObject]] else {
            return nil;
        }
        
        return value;
    }
    
    static func getArray(fromJson json:[String:AnyObject], forKey key:String)-> [AnyObject]?{
        guard let value  = json[key] as? [AnyObject] else {
            return nil;
        }
        
        return value;
    }

    static func isObjectType(fromJson json:AnyObject)->Bool{
        return json.isKind(of: NSDictionary.self) ? true:false
    }
    
    static func isArrayType(fromJson json:AnyObject)->Bool{
        return json.isKind(of: NSArray.self) ? true:false
    }
}
