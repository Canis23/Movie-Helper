//
//  ViewController.swift
//  MovieHelp
//
//  Created by Canis on 2017/6/25.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var moviesNames = ["天后開麥拉","神偷奶爸3","變形金剛5","死小孩","接線員"]
    var moviesImages = ["天后開麥拉.jpg","神偷奶爸3.jpg","變形金剛5.jpg","死小孩.jpg","接線員.jpg"]
    
    var Movies:[Movie] = [Movie(name: "天後開麥拉", image: "天後開麥拉.jpg"), Movie(name: "神偷奶爸3", image: "神偷奶爸3.jpg"), Movie(name: "變形金剛5", image: "變形金剛5.jpg"), Movie(name: "死小孩", image: "死小孩.jpg"), Movie(name: "接線員", image: "天接線員.jpg")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 取得螢幕的尺寸
        let fullScreenSize = UIScreen.main.bounds.size
        
        // 建立 UITableView 並設置原點及尺寸
        let movieTableView = UITableView(frame: CGRect(x: 0, y: 20, width: fullScreenSize.width, height: fullScreenSize.height - 20), style: .grouped)
        
        // 註冊 cell 的樣式及名稱
        movieTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // 設置委任對象
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        // 分隔線的樣式
        movieTableView.separatorStyle = .singleLine
        
        // 分隔線的間距 四個數值分別代表 上、左、下、右 的間距
        movieTableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
        
        // 是否可以點選 cell
        movieTableView.allowsSelection = true
        
        // 是否可以多選 cell
        movieTableView.allowsMultipleSelection = false
        
        // 加入到畫面中
        self.view.addSubview(movieTableView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 必須實作的方法：每一組有幾個 cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movies.count
    }
    
    // 必須實作的方法：每個 cell 要顯示的內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取得 tableView 目前使用的 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        // 設置 Accessory 按鈕樣式
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.accessoryType = .checkmark
            } else if indexPath.row == 1 {
                cell.accessoryType = .detailButton
            } else if indexPath.row == 2 {
                cell.accessoryType = .detailDisclosureButton
            } else if indexPath.row == 3 {
                cell.accessoryType = .disclosureIndicator
            }
        }
        
        // 顯示的內容
        if let myLabel = cell.textLabel {
            myLabel.text = "\(Movies[indexPath.row].name)"
        }
        
        return cell
    }



}

