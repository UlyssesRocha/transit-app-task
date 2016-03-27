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
    
    
    //Hardcoded info
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.map.camera = GMSCameraPosition.cameraWithLatitude(LocationManager.sharedInstance.getCurrentUserLocation().latitude, longitude: LocationManager.sharedInstance.getCurrentUserLocation().longitude, zoom: 12)
        
        
        let originMarker = GMSMarker()
        originMarker.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
        originMarker.position = LocationManager.sharedInstance.getCurrentUserLocation()
        originMarker.title = "My Location"
        originMarker.map = self.map

        
        let destinationMarker = GMSMarker()
        destinationMarker.icon = GMSMarker.markerImageWithColor(UIColor.redColor())
        destinationMarker.position = CLLocationCoordinate2D(latitude: Constants.destLatitude, longitude: Constants.destLongitude)
        destinationMarker.title = "Destination"
        destinationMarker.map = self.map
    }
 }

