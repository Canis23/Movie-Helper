//
//  MovieDetailMoreTableViewController.swift
//  Movie Helper
//
//  Created by Canis on 2017/7/5.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit

class MovieDetailMoreTableViewController: UITableViewController {

    var choose:Choose!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detail"
        
        self.tableView.estimatedRowHeight = 36.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)

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
        return 5 //此處可修改tableView要的欄位數量
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieDetailMoreTableViewCell

        // Configure the cell...
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "導演"
            cell.valueLabel.text = choose.movie.director
        case 1:
            cell.fieldLabel.text = "主演"
            cell.valueLabel.text = choose.movie.actor
        case 2:
            cell.fieldLabel.text = "片長"
            cell.valueLabel.text = choose.movie.time
        case 3:
            cell.fieldLabel.text = "分級"
            cell.valueLabel.text = choose.movie.rating[0]
        case 4:
            cell.fieldLabel.text = "簡介"
            cell.valueLabel.text = choose.movie.introduction
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        return cell
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
