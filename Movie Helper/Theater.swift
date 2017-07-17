//
//  Theater.swift
//  Movie Helper
//
//  Created by Canis on 2017/7/6.
//  Copyright © 2017年 Canis. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit


class Theater {
    var name = ""
    var num = ""
    var location:CLLocation!
    var myRouteETT:TimeInterval!
    
    init(num:String,name:String,location:CLLocation!) {
        self.num = num
        self.name = name
        self.location = location
    }
    
    func getRoute(myLocationManager: CLLocationManager) {
        //var time:TimeInterval!
        let directionRequest = MKDirectionsRequest()
        
        let markUserLocation = MKPlacemark(coordinate: CLLocationCoordinate2DMake((myLocationManager.location?.coordinate.latitude)!, (myLocationManager.location?.coordinate.longitude)!), addressDictionary: nil)
        
        let markFinal = MKPlacemark(coordinate: CLLocationCoordinate2DMake(self.location.coordinate.latitude, self.location.coordinate.longitude), addressDictionary: nil)
        
        directionRequest.source = MKMapItem(placemark: markUserLocation)
        directionRequest.destination = MKMapItem(placemark: markFinal)
        
        directionRequest.transportType = MKDirectionsTransportType.automobile
        
        let directions = MKDirections(request: directionRequest)
        print("send R!\n\n")
        directions.calculate(
            completionHandler: {
                res,erro in
                if erro == nil{
                    let myRoute = res?.routes[0]
                    self.myRouteETT = myRoute?.expectedTravelTime
                    print("\n\n\(self.name),\(self.myRouteETT)\n\n")
                }
                else{
                    print("\(self.name)")
                    print(erro)
                }
            }
        )
    }
}
