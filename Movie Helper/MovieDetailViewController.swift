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
        connectServer(success: done)
    }
    
    func connectServer(success: @escaping((_ data:[Any]) -> ())){
        let url = URL(string: "http://selab2.ahkui.com:1000/api/MovieHelper/moviebug/\(movie.id)")
        let task = URLSession.shared.dataTask(with: url!){  data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else{
                print("data is empty")
                return
            }
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
                     //   print(json)
                     //let data = json as! String {
            success(json as! [Any])
              //      }
            
        }
        task.resume()
    }
    
    func done(_ data:[Any]){
            for i in data {
            
            let onedata = i as! [String:Any]
            if let intro = onedata["intro"] as? String {
                choose.movie.introduction = intro
            }
            if let versions = onedata["movietype"] as? [String] {
                choose.movie.versions = versions.sorted()
            }
            if let actor = onedata["actor"] as? String {
                choose.movie.actor = actor
            }
            if let dirtor = onedata["dirtor"] as? String {
                choose.movie.director = dirtor
            }
            
            
            //movies.append(dataa)
            
        }
        //print(movies.count)
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
        if segue.identifier == "showVersionChooser" {
                let destinationController = segue.destination as! MovieVersionTableViewController
                destinationController.choose = choose
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
