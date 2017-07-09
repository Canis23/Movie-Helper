//
//  MapViewController.swift
//  Movie Helper
//
//  Created by Canis on 2017/7/7.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var timeLabel: UILabel!
    
    var myLocationManager: CLLocationManager!
    var myAnnotation: MKPointAnnotation = MKPointAnnotation()
    var myRoute: MKRoute!
    
    var choose: Choose!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"
        
        // Do any additional setup after loading the view.
        timeLabel.text = "預估到達時間:" + choose.arrivedTime + "\n電影放映時間:" + choose.movieTime
        
        //userlacation
        /*   最好版
        //目標點位置
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = choose.movieTheater.location.coordinate
        objectAnnotation.title = choose.movieTheater.name
        mapView.addAnnotation(objectAnnotation)
        
        let latDelta = 0.01
        let longDelta = 0.01
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        let center:CLLocation = choose.movieTheater.location
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion( center: center.coordinate, span: currentLocationSpan)
        mapView.setRegion(currentRegion, animated: true)
        */
        //let g = GetRoute(theater: choose.movieTheater)
        
        //建立一個 CLLocationManager
        myLocationManager = CLLocationManager()
        // 設置委任對象
        myLocationManager.delegate = self
        // 距離篩選器 用來設置移動多遠距離才觸發委任方法更新位置
        //myLocationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        // 取得自身定位位置的精確度
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        mapView.delegate = self
        
        // 地圖樣式
        mapView.mapType = .standard
        
        // 顯示自身定位位置
        mapView.showsUserLocation = true
        
        // 允許縮放地圖
        mapView.isZoomEnabled = true
        
        
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = choose.movieTheater.location.coordinate
        objectAnnotation.title = choose.movieTheater.name
        mapView.addAnnotation(objectAnnotation)
        
        print("\(myLocationManager.location)")
        
        mapView.userTrackingMode = MKUserTrackingMode.follow

        locationManager(manager: myLocationManager, didUpdateLocations: [myLocationManager.location!])
        
        let directionRequest = MKDirectionsRequest()
        
        let markUserLocation = MKPlacemark(coordinate: CLLocationCoordinate2DMake((myLocationManager.location?.coordinate.latitude)!, (myLocationManager.location?.coordinate.longitude)!), addressDictionary: nil)
        
        let markFinal = MKPlacemark(coordinate: CLLocationCoordinate2DMake(choose.movieTheater.location.coordinate.latitude, choose.movieTheater.location.coordinate.longitude), addressDictionary: nil)
        
        directionRequest.source = MKMapItem(placemark: markUserLocation)
        directionRequest.destination = MKMapItem(placemark: markFinal)
        
        directionRequest.transportType = MKDirectionsTransportType.automobile
        
        let directions = MKDirections(request: directionRequest)
        print("HAHAHAHAHAHA~~~")
        directions.calculate(completionHandler: {
            response, erro in
            if erro == nil {
            self.myRoute = response!.routes[0] as MKRoute
            self.mapView.add(self.myRoute.polyline)
            print("time:\(self.myRoute.expectedTravelTime)")
            }
        })
        
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let myLineRenderer = MKPolylineRenderer(polyline: myRoute.polyline)
        
        myLineRenderer.strokeColor = UIColor.blue
        
        myLineRenderer.lineWidth = 3
        
        return myLineRenderer
        
    }
    
    private func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [CLLocation]!) {
        myLocationManager.stopUpdatingLocation()
        // 印出目前所在位置座標
        let currentLocation :CLLocation = locations[0] as CLLocation
        print("\(currentLocation.coordinate.latitude)")
        print(", \(currentLocation.coordinate.longitude)")
        // 地圖預設顯示的範圍大小 (數字越小越精確)
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        // 設置地圖顯示的範圍與中心點座標
        let center:CLLocation = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion( center: center.coordinate, span: currentLocationSpan)
        mapView.setRegion(currentRegion, animated: true)
        myLocationManager.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
            self.present( alertController, animated: true, completion: nil)
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



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

