//
//  TheaterChooserTableViewController.swift
//  Movie Helper
//
//  Created by Canis on 2017/6/29.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit

//很明顯的這邊就是用來選電影院的呦～
class TheaterChooserTableViewController: UITableViewController {

    var city:String!
    
    //我也不知道哪邊有哪些電影院,就先用這個當測試吧～
    var theaterTest = ["Test1", "Tset2", "Tset3"]
    
    //跟main.storyboard做差不多的事情
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //你看這邊就可以把那個橘橘的設定成什麼城市了唷
        self.title = city

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

    //這邊都是電影院也沒必要分類 , 所以return 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //不能確定他有幾間電影院啊 , 所以就交給陣列處理吧
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return theaterTest.count
    }

    //這邊就可以設定每個Cell裡面的值
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        // 顯示的內容
        if let myLabel = cell.textLabel {
            myLabel.text = "\(theaterTest[indexPath.row])"
        }
        
        return cell
    }
    
    //Cell就是按來選電影院的啊 , 所以要先設定他按了會發生什麼事情唷
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTimetable" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! TimetableTableViewController
                destinationController.cityName = theaterTest[indexPath.row]
                //把CityName傳過去,沒什麼用就是了----\\FF
            }
        }
    }

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
