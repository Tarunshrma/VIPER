//
//  MovieDetailViewModel.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 13/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation
struct MovieDetailViewModel {
    var name:String
    var actorName:String
    var actorScreenName:String?
    var directorName:String
    
    init(_ _name:String, actorName _actorName:String,directorName _directorName:String) {
        self.name  = _name;
        self.actorName = _actorName
        self.directorName = _directorName
    }
}
