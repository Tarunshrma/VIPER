//
//  MovieListViewModel.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 12/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation
struct MovieListViewModel {
    var id:Double
    var name:String
    var rating:String?
    var nominated:String?
    var releaseDate:String? //May be not decided for future release
    
    init(withId _id:Double,name _name:String) {
        self.id = _id
        self.name = _name
    }
    
}
