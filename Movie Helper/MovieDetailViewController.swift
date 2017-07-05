//
//  MovieDetailViewController.swift
//  Movie Helper
//
//  Created by Canis on 2017/6/29.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit

//這邊會顯示電影的詳細資料們唷
class MovieDetailViewController: UIViewController {

    @IBOutlet var movieImageView:UIImageView!
    @IBOutlet var movieGOButton:UIButton!
    
    var movie:Movie!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = movie.name
        movieImageView.image = UIImage(named: movie.image)
        
        //設定Button的樣子喔喔喔喔
        movieGOButton.layer.cornerRadius = 10 //圓角
        movieGOButton.layer.borderWidth = 1 //邊框
        movieGOButton.layer.borderColor = UIColor.lightGray.cgColor //顏色喔喔喔
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
