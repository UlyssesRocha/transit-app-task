//
//  ViewController.swift
//  TransitApp
//
//  Created by Ulysses on 3/25/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import UIKit
import GoogleMaps

class SearchViewController: UIViewController {

    @IBOutlet weak var map: GMSMapView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.map.camera = GMSCameraPosition.cameraWithLatitude(LocationManager.sharedInstance.getCurrentUserLocation().latitude, longitude: LocationManager.sharedInstance.getCurrentUserLocation().longitude, zoom: 12)
        
        let marker = GMSMarker()
        marker.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
        marker.position = LocationManager.sharedInstance.getCurrentUserLocation()
        marker.title = "My Location"
        marker.map = self.map        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

