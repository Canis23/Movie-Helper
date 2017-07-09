//
//  Theater.swift
//  Movie Helper
//
//  Created by Canis on 2017/7/6.
//  Copyright © 2017年 Canis. All rights reserved.
//

import Foundation
import CoreLocation


class Theater {
    var name = ""
    var num = ""
    
    var location:CLLocation!
    
    init(num:String,name:String,location:CLLocation!) {
        self.num = num
        self.name = name
        self.location = location
    }
}
