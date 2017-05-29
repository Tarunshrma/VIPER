//
//  BaseParser.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 11/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation

protocol BaseParserProtocol {
    func parseData()->AnyObject?
}

class BaseParser:BaseParserProtocol{
    let jsonData:AnyObject!;
    
    init(response jsonData:AnyObject!) {
        self.jsonData = jsonData;
    }
    
    func parseData()->AnyObject?{
        fatalError("parseData() is abstract and must be overriden!");
    }
    
}
