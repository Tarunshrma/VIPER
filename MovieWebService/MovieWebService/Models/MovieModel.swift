//
//  MovieModel.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 11/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation

struct MovieModel {
    var id:Double
    var name:String
    var filmRating:Float?
    var rating:Float?
    var nominated:Int?
    var releaseDate:Double? //May be not decided for future release
    
    init(withId _id:Double, name _name:String){
        self.id = _id
        self.name = _name
    }
}
