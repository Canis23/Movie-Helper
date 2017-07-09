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
    
    var id = ""
    var name = ""
    var image = ""
    var time = ""
    var rating:[String] = [""]
    
    var director = ""//導演
    var actor = ""//演員
    var introduction = ""//簡介
    var versions:[String] = []
    
    var imageData = NSData()
    
    init() {}
    
    /*init(name:String, image:String){
        self.name = name
        self.image = image
        
        let url  = URL(string: image)
        let nsdata = NSData(contentsOf: url!)
        
        self.imageData = nsdata!
        
    }*/
    
    func toNSData() {
        let url  = URL(string: image)
        let nsdata = NSData(contentsOf: url!)
        self.imageData = nsdata!
    }
    
}
