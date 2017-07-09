//
//  choose.swift
//  Movie Helper
//
//  Created by Canis on 2017/7/6.
//  Copyright © 2017年 Canis. All rights reserved.
//

import Foundation

class Choose{
    var movie:Movie
    var version = ""
    var city:City!
    var theater:Theater!
    
    var theaterNums:[String]!
    
    var timeTable:[Timetable] = []
    var getData:Bool = false
    
    init(movie:Movie) {
        self.movie = movie
    }
}
