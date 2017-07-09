//
//  TheaterChooserViewController.swift
//  Movie Helper
//
//  Created by Canis on 2017/7/8.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit

class TheaterChooserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var goButton: UIButton!
    
    var choose:Choose!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choose.city.theaters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        // Configure the cell...
        if let myLabel = cell.textLabel {
            myLabel.text = "\(choose.city.theaters[indexPath.row].name)"
            
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    //action
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTimetable" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! TimetableViewController
                //getTimetableData();
                choose.theater = choose.city.theaters[indexPath.row]
                destinationController.choose = choose
                
            }
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
