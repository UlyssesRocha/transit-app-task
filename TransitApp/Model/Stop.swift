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
    private let datetime:NSDate?
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

extension String {
    func toDateTime() -> NSDate? {
        //2015-04-17T13:30:00+02:00
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZZZ"
        let date = dateFormatter.dateFromString(self)
        
        return date
    }
}

