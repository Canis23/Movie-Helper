//
//  City.swift
//  Movie Helper
//
//  Created by Canis on 2017/7/6.
//  Copyright © 2017年 Canis. All rights reserved.
//

import Foundation


class City {
    var name = ""
    var theaters:[Theater] = []
    init(name:String) {
        self.name = name
    }
}
