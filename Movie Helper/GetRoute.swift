//
//  GetRoute.swift
//  Movie Helper
//
//  Created by Canis on 2017/7/10.
//  Copyright © 2017年 Canis. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class GetRoute:NSObject, CLLocationManagerDelegate{
    var myLocationManager: CLLocationManager!
    var myAnnotation: MKPointAnnotation = MKPointAnnotation()
    var myRoute = MKRoute()
    var time:TimeInterval = 0
    
    var theater:Theater!
    
    
    func getTime(theater:Theater) -> TimeInterval
    {
        self.theater = theater
        //建立一個 CLLocationManager
        myLocationManager = CLLocationManager()
        // 設置委任對象
        myLocationManager.delegate = self
        // 距離篩選器 用來設置移動多遠距離才觸發委任方法更新位置
        //myLocationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        // 取得自身定位位置的精確度
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        ask()
        locationManager(manager: myLocationManager, didUpdateLocations: [myLocationManager.location!])
        
        return self.time
    }
    
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [CLLocation]!) {
        myLocationManager.stopUpdatingLocation()
        // 印出目前所在位置座標
        let currentLocation :CLLocation = locations[0] as CLLocation
        print("\(currentLocation.coordinate.latitude)")
        print(", \(currentLocation.coordinate.longitude)")
        
        let directionRequest = MKDirectionsRequest()
        
        let markUserLocation = MKPlacemark(coordinate: CLLocationCoordinate2DMake((myLocationManager.location?.coordinate.latitude)!, (myLocationManager.location?.coordinate.longitude)!), addressDictionary: nil)
        
        let markFinal = MKPlacemark(coordinate: CLLocationCoordinate2DMake(self.theater.location.coordinate.latitude, self.theater.location.coordinate.longitude), addressDictionary: nil)
        
        directionRequest.source = MKMapItem(placemark: markUserLocation)
        directionRequest.destination = MKMapItem(placemark: markFinal)
        
        directionRequest.transportType = MKDirectionsTransportType.automobile
        
        let directions = MKDirections(request: directionRequest)
        print("GetRoute directions")
        
        directions.calculate(completionHandler: {
            response, erro in
            if erro == nil {
                while !directions.isCalculating {}
                self.myRoute = response!.routes[0] as MKRoute
                self.time = self.myRoute.expectedTravelTime
                print("GetRoute time:\(self.myRoute.expectedTravelTime)")
            }
        })
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
            //present( alertController, animated: true, completion: nil)
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
    
}
