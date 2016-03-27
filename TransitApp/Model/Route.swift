//
//  Route.swift
//  TransitApp
//
//  Created by Ulysses on 3/25/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import Foundation
import CoreLocation


public class Route: NSObject {
    
    //Possible types of routes
    public enum Type:String{
        case public_transport, car_sharing, private_bike , bike_sharing , taxi
        
        func getName() -> String {
            switch self {
            case .public_transport:
                return "Public Transport"
            case .car_sharing:
                return "Car Sharing"
            case .private_bike:
                return "Private Bike"
            case .bike_sharing:
                return "Bike Sharing"
            case .taxi:
                return "Taxi"
            }
        }
    }

    let type:Type
    let provider:String
    var segments:[Segment] = []
    let properties:[String: AnyObject]?
    let currency:String?
    let amount:Double?

    init(dataDictionary:[String: AnyObject]){
        
        let typeString = dataDictionary["type"] as! String
        self.type = Type(rawValue: typeString)!
        
        self.provider = dataDictionary["provider"] as! String
        self.properties = dataDictionary["properties"] as? [String: AnyObject]
        
        if let price = dataDictionary["price"] as? [String: AnyObject]{
            self.currency = price["currency"] as? String
            self.amount = price["amount"] as? Double
        }else{
            self.currency = nil
            self.amount = nil
        }
        
        if let segmentsDictionary = dataDictionary["segments"]{
            for segment in segmentsDictionary.allObjects{
                let segmentObject = Segment(dataDictionary: segment as! [String : AnyObject])
                self.segments.append(segmentObject)
            }
        }
    }
    
    func getPrice()->String?{
        if let price = self.amount{
            return String(price)+" "+String(self.currency!.currencySymbol())
        }
        return nil
    }

    func getMoveSegment(id:Int)->Segment?{
        let moveSegments = self.segments.filter { (segment) -> Bool in
            segment.isMoveSegment()
        }
        
        if (id >= 0 && id < moveSegments.count){
            return moveSegments[id]
        }
        return nil
    }
    
    func numberOfMoveSegments()->Int{
        var count = 0
        for i in self.segments{
            if i.isMoveSegment(){
                count += 1
            }
        }
        return count
    }
    
    func getProperties()->NSDictionary?{
        if self.properties == nil {
            return nil
        }
        let elementProperties:NSMutableDictionary = NSMutableDictionary()
        //Taxi Special case
        if self.type == .taxi{
            for item in self.properties!["companies"]!.allObjects{
                let key = item["name"] as! String
                let value = item["phone"] as? String
                
                elementProperties[key] = value!
            }
        }else{
            for item in self.properties!{
                let key = item.0.stringByReplacingOccurrencesOfString("_", withString: " ").capitalizedString
                if let value = item.1 as? String{
                    elementProperties[key] = value
                }
            }
        }
        return elementProperties
    }
    
    
    func getTravelTime()->NSTimeInterval{
      return self.getArrivelTime()!.timeIntervalSinceDate(getStartTime()!)
    }
    
    func getStartTime()->NSDate?{
        return self.segments.first?.getStartTime()
    }

    func getArrivelTime()->NSDate?{
       return self.segments.last?.getArrivalTime()
    }
    
    func getStartPoint()->CLLocationCoordinate2D?{
        return self.segments.first?.getStartPoint()
    }
    
    func getDestinationPoint()->CLLocationCoordinate2D?{
        return self.segments.last?.getDestinationPoint()
    }
    
}
