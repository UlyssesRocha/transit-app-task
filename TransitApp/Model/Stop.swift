//
//  Stop.swift
//  TransitApp
//
//  Created by Ulysses on 3/25/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import CoreLocation

public class Stop: NSObject {
    private let location:CLLocationCoordinate2D
    private let datetime:NSDate
    private let name:String?
    
    init(dataDictionary:[String: AnyObject]){
        self.location = CLLocationCoordinate2D()
        self.datetime = NSDate()
        self.name = " "
    }
}
