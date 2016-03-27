//
//  Segment.swift
//  TransitApp
//
//  Created by Ulysses on 3/25/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import UIKit
import CoreLocation

public class Segment: NSObject {
    
    //Segments
    public enum Mode:String{
        case walking, subway, bus, driving, cycling, setup, parking, change
    }

    let name:String?
    private let numStops:Int
    let travelMode:Mode
    private let segmentDescription: String?
    let color:CIColor?
    
    var iconImage:UIImage?
    let iconUrl:String
    let polyline:String?
    
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
        
        self.iconUrl = dataDictionary["icon_url"] as! String
        self.polyline = dataDictionary["polyline"] as? String
        
        if let stopDictionary = dataDictionary["stops"]{
            for stop in stopDictionary.allObjects{
                let stopPoint = Stop(dataDictionary: stop as! [String : AnyObject])
                self.stops.append(stopPoint)
            }
        }
    }
    
    func isMoveSegment()->Bool{
        if self.travelMode.hashValue > 4{
            return false
        }
        return true
    }
        
    func getStartTime()->NSDate?{
        return self.stops.first?.datetime
    }
    
    func getArrivalTime()->NSDate?{
        return self.stops.last?.datetime
    }
    
    func getStartPoint()->CLLocationCoordinate2D?{
        return self.stops.first?.location
    }
    
    func getDestinationPoint()->CLLocationCoordinate2D?{
        return self.stops.last?.location
    }

}
