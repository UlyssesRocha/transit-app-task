//
//  Segment.swift
//  TransitApp
//
//  Created by Ulysses on 3/25/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import UIKit

public class Segment: NSObject {
    
    //Segments
    public enum Mode{
        case walking, subway, bus, driving, cycling, setup, parking, change
    }

    private let name:String?
    private let numStops:Int

    private let travelMode:Mode
    
    private let segmentDescription: String
    private let color:UIColor
    
    private var iconImage:UIImage?
    private let iconUrl:NSURL
    
    private let polyline:String
    
    init(dictionary:[String: AnyObject]){
        self.name = ""
        self.numStops = 0
        self.travelMode = .bus
        self.segmentDescription = ""
        self.color = UIColor()
        self.iconImage = nil
        self.iconUrl = NSURL()
        self.polyline = ""
    }

}
