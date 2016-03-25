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
    public enum Type{
        case public_transport, car_sharing, private_bike, bike_sharing, taxi
    }

    private let type:Type
    private let provider:String
    private let segments:[Segment]?
    private var properties:[String: AnyObject]?
    private let currency:String
    private let amount:Double

    init(dataDictionary:[String: AnyObject]){
        self.type = .private_bike
        self.provider = ""
        self.segments = nil
        self.properties = nil
        self.currency = ""
        self.amount = 0.0
    }
    
}
