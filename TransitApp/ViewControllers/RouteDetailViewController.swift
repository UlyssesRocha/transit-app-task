//
//  RouteDetailViewController.swift
//  TransitApp
//
//  Created by Ulysses on 3/26/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import UIKit
import GoogleMaps

class RouteDetailViewController: UITableViewController {

    weak var route:Route?

    @IBOutlet weak var mapView: GMSMapView!
    
    private weak var provider:Provider?
    
    /*
     Info
     Properties
     SegmentDetails
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.camera = GMSCameraPosition.cameraWithLatitude(self.route!.getStartPoint()!.latitude, longitude: self.route!.getStartPoint()!.longitude, zoom: 12)
        
        /*Place Marker in map*/
        let originMarker = GMSMarker()
        originMarker.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
        originMarker.position = self.route!.getStartPoint()!
        originMarker.title = "Origin"
        originMarker.map = self.mapView
        
        let destinationMarker = GMSMarker()
        destinationMarker.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
        destinationMarker.position = self.route!.getDestinationPoint()!
        destinationMarker.title = "Destination"
        destinationMarker.map = self.mapView
        
        /* Draw Segments*/
        for segment in route!.segments{
            if let polylineString = segment.polyline {
                let polylinePath = GMSPath(fromEncodedPath: polylineString)
                let polyline = GMSPolyline(path: polylinePath)
                polyline.map = mapView
                polyline.strokeColor = UIColor(CIColor: segment.color!)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("info", forIndexPath: indexPath)

        //Load Info About the route
        if indexPath.row < 4{
            switch indexPath.row {
            case 0:
                cell.textLabel!.text = "Type"
                cell.detailTextLabel!.text = self.route?.type.getName()
            case 1:
                cell.textLabel!.text = "Departure Time"
                cell.detailTextLabel!.text = self.route?.getStartTime()?.hoursAndMinuts()
            case 2:
                cell.textLabel!.text = "Arrival Time"
                cell.detailTextLabel!.text = self.route?.getArrivelTime()?.hoursAndMinuts()
            default:
                cell.textLabel!.text = "Price"
                if let price = self.route?.getPrice(){
                    cell.detailTextLabel!.text = price
                }else{
                    cell.detailTextLabel!.text = "Unknown"
                }
            }
            
        }
        
        //There is some properties to present?
        
        //Present the Segment Details of the Trip
        
        
        return cell
    }
    
   
   
}
