//
//  LocationManager.swift
//  TransitApp
//
//  Created by Ulysses on 3/25/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    static let sharedInstance = LocationManager()
    private override init() {}

    //MockData
    func getCurrentUserLocation()->CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: 52.530227, longitude: 13.403356)
    }
}
