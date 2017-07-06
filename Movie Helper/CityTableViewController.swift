//
//  PlaceChooserTableViewController.swift
//  Movie Helper
//
//  Created by Canis on 2017/6/29.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit

//這裡就是用來選地區的喔～
class CityTableViewController: UITableViewController {
    
    var choose:Choose!
    
    //台灣的縣市
    //因為縣跟市看起來都很複雜所以都省略
    //按照北,中,南,東,外島來分
    //cityName[哪區][哪個]
    /*var cityName = [
        ["台北", "新北", "桃園", "基隆", "宜蘭", "新竹"],
        ["苗栗", "台中", "南投", "彰化", "雲林"],
        ["嘉義", "台南", "高雄", "屏東"],
        ["台東", "花蓮"],
        ["澎湖", "金門", "馬祖"]
    ]*/
    
    /*
     1”>台北信義威秀影城
     2”>台北京站威秀影城
     3">台北日新威秀影城
     4”>板橋大遠百威秀影城
     5">林口MITSUI OUTLET PARK威秀影城
     7”>新竹大遠百威秀影城
     9”>新竹巨城威秀影城
     10”>頭份尚順威秀影城
     11”>台中大遠百威秀影城
     12">台中TIGER CITY威秀影城
     15”>台南大遠百威秀影城
     16”>台南南紡威秀影城
     18">高雄大遠百威秀影城
     */
    
    var cities:[[City]] = [
        [City(name:"台北", theaters:[Theater(name:"台北信義威秀影城"), Theater(name:"台北京站威秀影城"), Theater(name:"台北日新威秀影城")]),
         City(name:"新北", theaters:[Theater(name:"板橋大遠百威秀影城"), Theater(name:"林口MITSUI OUTLET PARK威秀影城")]),
         City(name:"桃園", theaters:[]),
         City(name:"基隆", theaters:[]),
         City(name:"宜蘭", theaters:[]),
         City(name:"新竹", theaters:[Theater(name:"新竹大遠百威秀影城"), Theater(name:"新竹巨城威秀影城")])],
        
        [City(name:"苗栗", theaters:[Theater(name:"頭份尚順威秀影城")]),
         City(name:"台中", theaters:[Theater(name:"台中大遠百威秀影城"), Theater(name:"台中TIGER CITY威秀影城")]),
         City(name:"南投", theaters:[]),
         City(name:"彰化", theaters:[]),
         City(name:"雲林", theaters:[])],
        
        [City(name:"嘉義", theaters:[]),
         City(name:"台南", theaters:[Theater(name:"台南大遠百威秀影城"), Theater(name:"台南南紡威秀影城")]),
         City(name:"高雄", theaters:[Theater(name:"高雄大遠百威秀影城")]),
         City(name:"屏東", theaters:[])],
        
        [City(name:"台東", theaters:[]),
         City(name:"花蓮", theaters:[])],
        
        [City(name:"澎湖", theaters:[]),
         City(name:"金門", theaters:[]),
         City(name:"馬祖", theaters:[])]
    ]
    
    //差不多就main.storyboard可以做的事情
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //上面那個橘橘的 可以設定他的title
        self.title = "選擇地區"
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    //Cell的分類
    //因為這裡有各區,所以return的值不止1
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return cities.count
    }
    
    //各個Section裡面會有幾個Cell啊啊啊
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities[section].count
    }
    
    // 必須實作的方法：每個 cell 要顯示的內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取得 tableView 目前使用的 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        // 顯示的內容
        if let myLabel = cell.textLabel {
            myLabel.text = "\(cities[indexPath.section][indexPath.row].name)"
        }
        
        return cell
    }
    
    // 每個 section 的標題
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        if(section == 0){
            title = "北區"
        }
        else if(section == 1){
            title = "中區"
        }
        else if(section == 2){
            title = "南區"
        }
        else if(section == 3){
            title = "東區"
        }
        else if(section == 4){
            title = "外島"
        }
        return title
    }
    
    //點了Cell會發生什麼事情啊ㄎㄎ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieTheaterChooser" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! TheaterChooserTableViewController
                choose.city = cities[indexPath.section][indexPath.row]
                destinationController.choose = choose
                //TheaterChooserTableViewController那邊用一個String來接這邊傳過去的cityName
                //然後就可以把它設定成title摟喔喔喔喔喔
                //沒錯就是那個橘橘的
            }
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
