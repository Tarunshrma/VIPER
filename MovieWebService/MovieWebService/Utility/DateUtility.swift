//
//  DateUtility.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 12/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation
class DateUtility{
    
    static func convertDate(_ date:Date, toFormat format:String)-> String?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: Locale.autoupdatingCurrent)
        
        return dateFormatter.string(from: date)
        
    }
}
