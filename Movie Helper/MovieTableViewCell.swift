//
//  MovieTableViewCell.swift
//  Movie Helper
//
//  Created by Canis on 2017/6/22.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit


//這個TableViewCell是給MovieTableViewController用的
//就那個有Label跟ImageView那個Cell
class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layoutMargins = UIEdgeInsets.zero
        //self.nameLabel.layer.backgroundColor = UIColor.gray.cgColor
        self.nameLabel.layer.borderWidth = 0
        self.nameLabel.layer.cornerRadius = 10
        
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
