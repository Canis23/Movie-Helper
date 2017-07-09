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
    
    var movieTime = ""
    
    let g = GetRoute()
    
    //緩衝時間 秒為單位 1200秒=20分鐘
    let bufferTime:TimeInterval = 1200
    var arrivedTime = ""
    
    init(movie:Movie) {
        self.movie = movie
    }
    
    
}
