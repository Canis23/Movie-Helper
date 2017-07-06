//
//  Movie.swift
//  Movie Helper
//
//  Created by Canis on 2017/6/22.
//  Copyright © 2017年 Canis. All rights reserved.
//

import Foundation

//Movie class
class Movie{
    var name = ""
    var image = ""
    var imageData = NSData()
    var isVisited = false
    init(name:String, image:String){
        self.name = name
        self.image = image
        
        let url  = URL(string: image)
        let nsdata = NSData(contentsOf: url!)
        
        self.imageData = nsdata!
        
    }
}
