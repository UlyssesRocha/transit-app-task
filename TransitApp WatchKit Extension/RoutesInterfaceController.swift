//
//  InterfaceController.swift
//  TransitApp WatchKit Extension
//
//  Created by Ulysses on 3/25/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import WatchKit
import Foundation


class RoutesInterfaceController: WKInterfaceController {

    private var routes:[Route]? = nil
    
    @IBOutlet var tableView: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        /*Loading TableView*/
        DataManager.sharedInstance.loadRoutes("", destination: "", atTime: nil) { (routes, providers, error) in
            self.routes = routes
            self.tableView.setNumberOfRows(self.routes!.count, withRowType: "RouteRow")

            for rowCounter in 0..<self.routes!.count {
                if let row = self.tableView.rowControllerAtIndex(rowCounter) as? RouteRow {
                    row.loadWithRoute(self.routes![rowCounter])
                }
            }
        }
        
    }

    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let context = routes![rowIndex]
        self.pushControllerWithName("RouteDetail", context:context)
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
