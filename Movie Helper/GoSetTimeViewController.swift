//
//  GoSetTimeViewController.swift
//  Movie Helper
//
//  Created by Canis on 2017/7/18.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit

class GoSetTimeViewController: UIViewController {

    @IBOutlet var setTimeSlider: UISlider!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var goButton: UIButton!
    
    
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
        
        goButton.layer.cornerRadius = 10
        
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
        if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
            /*...
             find the best theater and time
             ...*/
            getMovieTime()
            //計算下一場時間
            destinationController.choose = choose
        }
    }
    
    func getMovieTime() {
        var approachTime = ""
        var nowDate = Date()
        nowDate.addTimeInterval(choose.theater.myRouteETT) //到電影院要花費的時間
        nowDate.addTimeInterval(choose.bufferTime)//choose設定的20分鐘buffer time
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let nowTime = formatter.string(from: nowDate)
        choose.arrivedTime = nowTime
        for time in choose.timeTable[0].times{
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
