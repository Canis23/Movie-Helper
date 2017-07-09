//
//  TimetableTableViewCell.swift
//  Movie Helper
//
//  Created by Canis on 2017/7/9.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit

class TimetableTableViewCell: UITableViewCell {
    
    @IBOutlet var dayLabel:UILabel!
    @IBOutlet var morTimeLabel:UILabel!
    @IBOutlet var aftTimeLabel:UILabel!
    @IBOutlet var nigTimeLabel:UILabel!
    @IBOutlet var midTimeLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
