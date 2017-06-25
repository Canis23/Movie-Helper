//
//  movieTabelViewCell.swift
//  MovieHelp
//
//  Created by Canis on 2017/6/25.
//  Copyright © 2017年 Canis. All rights reserved.
//

import Foundation
import UIKit


class movieTabelViewCell : UITableViewCell
{
    var movieNameLabel = UILabel()
    var movieImageView = UIImageView()
    
    init(name:String, image:String){
        self.movieNameLabel.text = name
        self.movieImageView.image = UIImage(named: "\(image)")
    }
}
