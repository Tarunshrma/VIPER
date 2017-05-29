//
//  MovieDetailModel.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 13/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation
struct MovieDetailModel{
    var id:Double
    var name:String
    var actors:[ActorModel]?
    var director:DirectorModel?
    var filmRating:Float?
    var rating:Float?
    var languages:[String]?
    var nominated:Int?
    var releaseDate:Double? //May be not decided for future release

    
    init(withId _id:Double, name _name:String){
        self.id = _id
        self.name = _name
    }
}
