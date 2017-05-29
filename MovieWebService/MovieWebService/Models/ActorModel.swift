//
//  ActorModel.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 11/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation

protocol MoviePeople{
    var dateOfBirth:Double? {get}
    var nominated:Int? {get set}
    var name:String? {get}
    var biography:String? {get set}
}

struct ActorModel:MoviePeople {
    var biography: String?
    var name: String?
    var nominated: Int?
    var dateOfBirth: Double?
    var screenName: String?
    
}
