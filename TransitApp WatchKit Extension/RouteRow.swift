//
//  RouteRow.swift
//  TransitApp
//
//  Created by Ulysses on 3/27/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import WatchKit

class RouteRow: NSObject {

    @IBOutlet var nameLabel: WKInterfaceLabel!
    @IBOutlet var priceLabel: WKInterfaceLabel!
    @IBOutlet var arrivalTime: WKInterfaceLabel!
    @IBOutlet var providerLabel: WKInterfaceLabel!
    
    func loadWithRoute(route:Route){
        self.nameLabel.setText(route.type.getName())
        self.priceLabel.setText(route.getPrice())
        self.arrivalTime.setText(route.getArrivelTime()?.hoursAndMinuts())
        self.providerLabel.setText(route.provider)
    }
}
