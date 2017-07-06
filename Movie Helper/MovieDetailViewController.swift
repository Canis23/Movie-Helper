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
    var choose:Choose!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        choose = Choose(movie: movie)
        /* choose setting*/
        
        
        
        /*---------------*/
        
        navigationController?.hidesBarsOnSwipe = false
        
        self.title = movie.name
        movieImageView.image = UIImage(data: movie.imageData as Data)
        
        //設定Button的樣子喔喔喔喔
        movieGOButton.layer.cornerRadius = 10 //圓角
        movieGOButton.layer.borderWidth = 1 //邊框
        movieGOButton.layer.borderColor = UIColor.lightGray.cgColor //顏色喔喔喔
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCityChooser" {
                let destinationController = segue.destination as! CityTableViewController
                destinationController.choose = choose
                //TheaterChooserTableViewController那邊用一個String來接這邊傳過去的cityName
                //然後就可以把它設定成title摟喔喔喔喔喔
                //沒錯就是那個橘橘的
        }
        else if segue.identifier == "showDetailMore" {
            let destinationController = segue.destination as! MovieDetailMoreTableViewController
            destinationController.choose = choose
        }
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
