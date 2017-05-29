//
//  APIEndpoints.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 11/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation
import UIKit

enum APIEndPoints:String {
    case Movies         = "movies"
    case MovieDetails   = "movieDetails"
    
    func getParser(jsonData:AnyObject)->BaseParserProtocol{
        
        let parser:BaseParserProtocol
        
        switch self{
            
            case .Movies:
                parser =  MovieParser(response: jsonData)
            case .MovieDetails:
                parser =  MovieDetailParser(response: jsonData)

        }
        
        return parser;
    }

    
}
