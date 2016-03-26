//
//  RoutesTableViewController.swift
//  TransitApp
//
//  Created by Ulysses on 3/26/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import UIKit

class RoutesTableViewController: UITableViewController {
    
    private var routes:[Route]?
    private var providers:[Provider]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataManager.sharedInstance.loadRoutes("", destination: "", atTime: nil) { (routes, providers, error) in
            if error != nil{
                return
            }
            self.routes = routes
            self.providers = providers
            
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.routes == nil{
            return 0
        }
        return routes!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("routeCell", forIndexPath: indexPath) as! RouteTableViewCell
        
        cell.load(routes![indexPath.row])

        return cell
    }

}
