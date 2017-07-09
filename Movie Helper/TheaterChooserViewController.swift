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
    var times:[TimeInterval]! = []
    var movieTimes:[[String]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for theater in choose.city.theaters{
            times.append(choose.g.getTime(theater: theater))
            connectServer(success: done, theater: theater)
        }
        
        title = choose.city.name

        // Do any additional setup after loading the view.
    }
    
    //爬下Json
    func connectServer(success: @escaping((_ data:[Any]) -> ()) , theater:Theater){
        let url = URL(string: "http://selab2.ahkui.com:1000/api/MovieHelper/moviebug/\(choose.movie.id)/\(theater.num)/\(choose.version)")
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
            
            
            let onedata = i as! [String:Any]
            if let times = onedata["time"] as? [String] {
               movieTimes.append(times)
            }
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
                choose.theater = choose.city.theaters[indexPath.row]
                destinationController.choose = choose
                
            }
        }
        else if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
            /*...
             find the best theater and time
             ...*/
            getBestTheater()
            destinationController.choose = choose
        }
    }
    
    func parseDuration(timeString:String) -> TimeInterval {
        guard !timeString.isEmpty else {
            return 0
        }
        
        var interval:Double = 0
        
        let parts = timeString.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        
        return interval
    }
    
    func getBestTheater ()
    {
        var bestTheater:Theater!
        var approachTime = ""
        var bestTime = ""
        var bestTimeX:TimeInterval = -1
        
        /*擷取現在時間*/
        
        var nowDate = Date()
        nowDate.addTimeInterval(choose.bufferTime)//choose設定的20分鐘buffer time
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        /*以上為共同時間*/
        
        for index in 0 ..< choose.city.theaters.count{
            nowDate.addTimeInterval(times[index])
            let nowTime = formatter.string(from: nowDate)
            //計算各影城最優時間
            for time in movieTimes[index]{
                if nowTime < "24:00" {
                    if time > nowTime{
                        approachTime = time
                        break
                    }
                }
                else {
                    if time > nowTime && time < "06:00"{
                        approachTime = time
                        break
                    }
                }
            }
            let time1 = parseDuration(timeString: approachTime)
            let time2 = parseDuration(timeString: nowTime)
            if (bestTimeX < time1 - time2) || bestTimeX<0 {
                bestTime = approachTime
                bestTimeX = time1 - time2
                bestTheater = choose.city.theaters[index]
                choose.arrivedTime = nowTime
            }
            
        
        choose.theater = bestTheater
        choose.movieTime = bestTime
            
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
}
