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

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var timeLabel: UILabel!
    
    var myLocationManager: CLLocationManager!
    var myAnnotation: MKPointAnnotation = MKPointAnnotation()
    
    var choose: Choose!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"

        // Do any additional setup after loading the view.
        timeLabel.text = choose.movieTime
        
        
        
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
