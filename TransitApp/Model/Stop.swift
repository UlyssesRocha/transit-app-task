//
//  Stop.swift
//  TransitApp
//
//  Created by Ulysses on 3/25/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import CoreLocation

public class Stop: NSObject {
    private let location:CLLocationCoordinate2D?
    let datetime:NSDate?
    private let name:String?
    
    init(dataDictionary:[String: AnyObject]){
        let latitude = dataDictionary["lat"] as? CLLocationDegrees
        let longitude = dataDictionary["lng"] as? CLLocationDegrees
        
        self.location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)

        let timeString = dataDictionary["datetime"] as? String
        self.datetime = timeString!.toDateTime()

        let stopString = dataDictionary["name"] as? String
        self.name = stopString
    }
}


