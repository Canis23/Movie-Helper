//
//  TheaterChooserViewController.swift
//  Movie Helper
//
//  Created by Canis on 2017/7/8.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class TheaterChooserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var goButton: UIButton!
    
    var choose:Choose!
    var movieTimes:[[String]] = []
    
    var myLocationManager: CLLocationManager!
    var myAnnotation: MKPointAnnotation = MKPointAnnotation()
    //var myRoute = MKRoute()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLocationManager = CLLocationManager()
        // 設置委任對象
        myLocationManager.delegate = self
        // 距離篩選器 用來設置移動多遠距離才觸發委任方法更新位置
        //myLocationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        // 取得自身定位位置的精確度
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        ask()
        myLocationManager.stopUpdatingHeading()
        for theater in choose.city.theaters{
            print("Send R:\(theater.name)")
            theater.getRoute(myLocationManager: self.myLocationManager)
        }
        myLocationManager.startUpdatingHeading()
        for theater in choose.city.theaters{
            connectServer(success: done, theater: theater)
            //print("\n\n\n\(time)\n\n\n")
            //times.append(choose.g.time)
        }
        
        
        title = choose.city.name

        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //myLocationManager.stopUpdatingLocation()
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
            print(json)
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
        if choose.city.theaters.count == 0{
            self.goButton.isHighlighted = true
            self.goButton.isEnabled = false
        }
        else{
            self.goButton.isEnabled = true
        }
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
        else if segue.identifier == "showGoSet" {
            let destinationController = segue.destination as! GoSetDTViewController
            /*...
             find the best theater and time
             ...*/
            choose.theater = nil
            destinationController.choose = choose
            destinationController.movieTimes = movieTimes
        }
    }
    
    
    func ask() {
        // 首次使用 向使用者詢問定位自身位置權限
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // 取得定位服務授權
            myLocationManager.requestWhenInUseAuthorization()
            
            // 開始定位自身位置
            myLocationManager.startUpdatingLocation()
            
        }
            // 使用者已經拒絕定位自身位置權限
        else if CLLocationManager.authorizationStatus() == .denied {
            // 提示可至[設定]中開啟權限
            let alertController = UIAlertController( title: "定位權限已關閉", message: "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "確認", style: .default, handler:nil)
            alertController.addAction(okAction)
            present( alertController, animated: true, completion: nil)
        }
            // 使用者已經同意定位自身位置權限
        else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // 開始定位自身位置
            myLocationManager.startUpdatingLocation()
            
        }
        else{
            myLocationManager.startUpdatingLocation()
            
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
