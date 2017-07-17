//
//  TimetableViewController.swift
//  Movie Helper
//
//  Created by Canis on 2017/7/8.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class TimetableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet var goButton:UIButton!
    
    var choose:Choose!
    var time:TimeInterval!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = choose.theater.name
        self.tableView.estimatedRowHeight = 36.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        // Do any additional setup after loading the view.
        choose.timeTable = []
        connectServer(success: done)
        tableView.reloadData()
    }
    
    
    func connectServer(success: @escaping((_ data:[Any]) -> ())){
        let url = URL(string: "http://selab2.ahkui.com:1000/api/MovieHelper/moviebug/\(choose.movie.id)/\(choose.theater.num)/\(choose.version)")

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
               //print("\(self.choose.movie.id)/\(self.choose.theater.num)/\(self.choose.version)")
               //print(json)
            //if let data = json as! String {
                success(json as! [Any])
            //      }
            
        }
        task.resume()
    }
    
    func done(_ data:[Any]){
        for i in data {
            
            let dataa:Timetable = Timetable()
            
            let onedata = i as! [String:Any]
            if let times = onedata["time"] as? [String] {
                dataa.times = times
                
            }
            if let day = onedata["movieDay"] as? String {
                dataa.day = day
            }
            choose.timeTable.append(dataa)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        return choose.timeTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TimetableTableViewCell
        var morTime = ""
        var aftTime = ""
        var nigTime = ""
        var midTime = ""
        
        //Cell Setting
        cell.dayLabel.text = choose.timeTable[indexPath.row].day
        
        for time in choose.timeTable[indexPath.row].times{
            if(time < "12:00" && time > "06:00"){
                morTime += "\(time)\n"
            }
            else if(time < "18:00" && time > "12:00"){
                aftTime += "\(time)\n"
            }
            else if(time < "24:00" && time > "18:00"){
                nigTime += "\(time)\n"
            }
            else{
                midTime += "\(time)\n"
            }
            
        }
        
        cell.morTimeLabel.text = morTime
        cell.aftTimeLabel.text = aftTime
        cell.nigTimeLabel.text = nigTime
        cell.midTimeLabel.text = midTime
        
        
        return cell
    }
    
    //action
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSet" {
            let destinationController = segue.destination as! GoSetTimeViewController
            /*...
             find the best theater and time
             ...*/
            //計算下一場時間
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
