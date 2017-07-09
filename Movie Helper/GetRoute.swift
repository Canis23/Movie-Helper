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
        print("directions")
        
        directions.calculate(completionHandler: {
            response, erro in
            if erro == nil {
                self.myRoute = response!.routes[0] as MKRoute
                self.time = self.myRoute.expectedTravelTime
                print("time:\(self.myRoute.expectedTravelTime)")
            }
        })
    }
    
}
