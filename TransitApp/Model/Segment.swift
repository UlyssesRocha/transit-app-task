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
    public enum Mode:String{
        case walking, subway, bus, driving, cycling,  setup, parking, change
    }

    private let name:String?
    private let numStops:Int

    private let travelMode:Mode
    
    private let segmentDescription: String?
    private let color:CIColor?
    
    private var iconImage:UIImage?
    private let iconUrl:NSURL
    private let polyline:String?
    
    private var stops:[Stop] = []
    
    init(dataDictionary:[String: AnyObject]){
        self.name = dataDictionary["name"] as? String
        self.numStops = dataDictionary["num_stops"] as! Int
        
        let modeString = dataDictionary["travel_mode"] as! String
        self.travelMode = Mode(rawValue: modeString)!
        
        self.segmentDescription = dataDictionary["description"] as? String
        
        let hexColor = dataDictionary["color"] as! String
        self.color = CIColor(string: hexColor)
        
        self.iconImage = nil
        
        let urlString = dataDictionary["icon_url"] as! String
        self.iconUrl = NSURL(fileURLWithPath: urlString)
        self.polyline = dataDictionary["polyline"] as? String
        
        if let stopDictionary = dataDictionary["stops"]{
            for stop in stopDictionary.allObjects{
                let stopPoint = Stop(dataDictionary: stop as! [String : AnyObject])
                self.stops.append(stopPoint)
            }
        }

    }

}
