//
//  Route.swift
//  TransitApp
//
//  Created by Ulysses on 3/25/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import Foundation

public class Route: NSObject {
    
    //Possible types of routes
    public enum Type:String{
        case public_transport, car_sharing, private_bike , bike_sharing , taxi
    }

    private let type:Type
    private let provider:String
    private var segments:[Segment] = []
    private var properties:[String: AnyObject]?
    private var currency:String? = nil
    private var amount:Double? = nil

    init(dataDictionary:[String: AnyObject]){
        
        let typeString = dataDictionary["type"] as! String
        self.type = Type(rawValue: typeString)!
        
        self.provider = dataDictionary["provider"] as! String
        self.properties = dataDictionary["properties"] as? [String: AnyObject]
        
        if let price = dataDictionary["price"] as? [String: AnyObject]{
            self.currency = price["currency"] as? String
            self.amount = price["amount"] as? Double
        }
        
        if let segmentsDictionary = dataDictionary["segments"]{
            for segment in segmentsDictionary.allObjects{
                let segmentObject = Segment(dataDictionary: segment as! [String : AnyObject])
                self.segments.append(segmentObject)
            }
        }

    }
    
}
