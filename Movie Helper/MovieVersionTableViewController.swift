//
//  MovieVersionTableViewController.swift
//  Movie Helper
//
//  Created by Canis on 2017/7/7.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit

class MovieVersionTableViewController: UITableViewController {

    var choose:Choose!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Version"
        
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return choose.movie.versions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        var versionNum:String
        if let myLabel = cell.textLabel {
            versionNum = choose.movie.versions[indexPath.row]
            if(versionNum == "1"){
                myLabel.text = "數位版"
            }
            else if(versionNum == "2"){
                myLabel.text = "數位3D"
            }
            else if(versionNum == "3"){
                myLabel.text = "IMAX"
            }
            else if(versionNum == "4"){
                myLabel.text = "IMAX 3D"
            }
            else if(versionNum == "8"){
                myLabel.text = "4DX"
            }
            else if(versionNum == "9"){
                myLabel.text = "4DX3D"
            }
            else if(versionNum == "10"){
                myLabel.text = "MAPPA"
            }
            else if(versionNum == "12"){
                myLabel.text = "現場演出"
            }
            else{
                myLabel.text = versionNum
            }
        }
        
        return cell
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCityChooser" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! CityTableViewController
                choose.version = choose.movie.versions[indexPath.row]
                destinationController.choose = choose
                //TheaterChooserTableViewController那邊用一個String來接這邊傳過去的cityName
                //然後就可以把它設定成title摟喔喔喔喔喔
                //沒錯就是那個橘橘的
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
