//
//  GoViewController.swift
//  Movie Helper
//
//  Created by Canis on 2017/7/18.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit

class GoSetDTViewController: UIViewController {

    @IBOutlet var setTimeSlider: UISlider!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var shortestDisButton: UIButton!
    @IBOutlet var shortestTimeButton: UIButton!
    
    
    var choose: Choose!
    var movieTimes:[[String]] = []
    var bufTime: Double = 2100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choose.bufferTime = bufTime
        title = "Go Set"
        
        setTimeSlider.minimumValue = 10
        setTimeSlider.maximumValue = 60
        setTimeSlider.value = 35
        setTimeSlider.isContinuous = true
        
        // UISlider 滑動滑桿時執行的動作
        setTimeSlider.addTarget(self,action:#selector(self.onSliderChange), for: .valueChanged)
        
        shortestDisButton.layer.cornerRadius = 10
        shortestTimeButton.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onSliderChange() {
        timeLabel.text = "\(Int(setTimeSlider.value))"
        bufTime = Double(setTimeSlider.value*60)
        choose.bufferTime = bufTime
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDisMap" {
            let destinationController = segue.destination as! MapViewController
            /*...
             find the best theater and time
             ...*/
            getSDisTheater()
            destinationController.choose = choose
        }
        else if segue.identifier == "showTimeMap" {
            let destinationController = segue.destination as! MapViewController
            /*...
             find the best theater and time
             ...*/
            getSTimeTheater()
            destinationController.choose = choose
        }
    }
    
    func getSDisTheater ()
    {
        var bestTheater:Theater!
        var approachTime = ""
        var bestTime = ""
        var bestTimeX:TimeInterval = 0
        
        
        
        for index in 0 ..< choose.city.theaters.count{
            
            var nowDate = Date()
            nowDate.addTimeInterval(choose.bufferTime)//choose設定的20分鐘buffer time
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            
            
            nowDate.addTimeInterval(choose.city.theaters[index].myRouteETT)
            
            let nowTime = formatter.string(from: nowDate)
            //計算各影城最優時間
            for time in movieTimes[index]{
                if nowTime < "24:00" {
                    if time > "06:00" {
                        if time > nowTime{
                            approachTime = time
                            break
                        }
                    }
                    else {
                        approachTime = time
                        break
                    }
                    
                }
                else {
                    if time < nowTime && time < "06:00"{
                        approachTime = time
                        break
                    }
                }
            }
            let time1 = parseDuration(timeString: approachTime)
            let time2 = parseDuration(timeString: nowTime)
            if (bestTimeX > time1 - time2) || bestTimeX==0 {
                print("\n\n\(choose.city.theaters[index].name),\(time1 - time2)")
                bestTime = approachTime
                bestTimeX = time1 - time2
                bestTheater = choose.city.theaters[index]
                choose.arrivedTime = nowTime
            }
        }
        choose.theater = bestTheater
        choose.movieTime = bestTime
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
    
    func getSTimeTheater() {
        var bestTheater:Theater!
        var bestIndex: Int!
        var approachTime = ""
        
        for index in 0 ..< choose.city.theaters.count{
            if bestTheater == nil {
                bestTheater = choose.city.theaters[index]
                bestIndex = index
            }
            else{
                if bestTheater.myRouteETT > choose.city.theaters[index].myRouteETT{
                    bestTheater = choose.city.theaters[index]
                    bestIndex = index
                }
            }
        }
        
        /*算時間*/
        var nowDate = Date()
        nowDate.addTimeInterval(choose.bufferTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        nowDate.addTimeInterval(bestTheater.myRouteETT)
        let nowTime = formatter.string(from: nowDate)
        
        //計算最優電影時間
        for time in movieTimes[bestIndex] {
            if nowTime < "24:00" {
                if time > "06:00" {
                    if time > nowTime{
                        approachTime = time
                        break
                    }
                }
                else {
                    approachTime = time
                    break
                }
                
            }
            else {
                if time < nowTime && time < "06:00"{
                    approachTime = time
                    break
                }
            }
        }
        
        choose.arrivedTime = nowTime
        choose.theater = bestTheater
        choose.movieTime = approachTime
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
