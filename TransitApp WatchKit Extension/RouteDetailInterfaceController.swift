//
//  RouteDetailInterfaceController.swift
//  TransitApp
//
//  Created by Ulysses on 3/27/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import WatchKit
import Foundation


class RouteDetailInterfaceController: WKInterfaceController {

    @IBOutlet var nameLabel: WKInterfaceLabel!
    @IBOutlet var priceLabel: WKInterfaceLabel!
    @IBOutlet var arrivalTime: WKInterfaceLabel!
    @IBOutlet var providerLabel: WKInterfaceLabel!
       @IBOutlet var tableView: WKInterfaceTable!
    
    @IBOutlet var DetailTableView: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        let route = context as! Route
        
        self.nameLabel.setText(route.type.getName())
        self.priceLabel.setText(route.getPrice())
        self.arrivalTime.setText(route.getArrivelTime()?.hoursAndMinuts())
        self.providerLabel.setText(route.provider)
        
        
        let numberOfSegments = route.numberOfMoveSegments()
        
        self.tableView.setNumberOfRows(numberOfSegments, withRowType: "SegmentRow")
        for rowCounter in 0..<numberOfSegments{
            if let row = self.tableView.rowControllerAtIndex(rowCounter) as? SegmentRow {
                row.loadWithSegment(route.getMoveSegment(rowCounter)!)
            }
        }
        
        //properties to present?
       if let details = route.getProperties(){
        
            self.DetailTableView.setNumberOfRows(details.count, withRowType: "DetailRow")
        
            for rowCounter in 0..<details.count{
                if let row = self.DetailTableView.rowControllerAtIndex(rowCounter) as? DetailRow {
                    let key = details.allKeys[rowCounter] as! String
                    let data = details[key] as! String

                    row.loadWithDictionary(key, data: data)
                }
            }
        }
        
        
    }


    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
