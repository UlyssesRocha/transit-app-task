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
    
    @IBOutlet weak var mapView: GMSMapView!
    
    private weak var provider:Provider?
    private var properties:NSDictionary?
    
    let sectionHeaderTitles = ["Information","Route","Details"]
    
    weak var route:Route?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.properties = self.route?.getProperties()
        self.loadMapInfo()
     }
    
    
    func loadMapInfo(){
        self.mapView.camera = GMSCameraPosition.cameraWithLatitude(self.route!.getStartPoint()!.latitude, longitude: self.route!.getStartPoint()!.longitude, zoom: 12)
        
        /*Place Marker in map*/
        
        self.placePin("Origin", position: self.route!.getStartPoint()!, color: UIColor.grayColor())
        self.placePin("Destination", position: self.route!.getDestinationPoint()!, color: UIColor.blueColor())

        /* Draw Segments*/
        for segment in route!.segments{
            
            //place a pin if is a "move" segment
            if segment.isMoveSegment(){
                self.placePin(segment.name ?? segment.travelMode.rawValue.capitalizedString, position: segment.getStartPoint()!, color: UIColor.redColor())
            }
            
            if let polylineString = segment.polyline {
                let polylinePath = GMSPath(fromEncodedPath: polylineString)
                let polyline = GMSPolyline(path: polylinePath)
                polyline.map = mapView
                polyline.strokeColor = UIColor.blueColor()
            }
        }
    }
      
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaderTitles[section]
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if self.properties == nil{
            return 2
        }
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 4
        }
        if section == 1 {
            return self.route!.numberOfMoveSegments()
        }
        
        return self.properties?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Load Info About the route
        if indexPath.section == 0{
           return infoCellForRowAtIndexPath(indexPath)
        }
        
        //Present the Segment Details of the Trip
        if indexPath.section == 1 {
           return segmentCellForRowAtIndexPath(indexPath)
        }
        
        //properties to present?
        return propertiesCellForRowAtIndexPath(indexPath)
    }
    
    
//MARK: Private Functions
    private func placePin(name:String,position:CLLocationCoordinate2D, color:UIColor){
        let destinationMarker = GMSMarker()
        destinationMarker.icon = GMSMarker.markerImageWithColor(color)
        destinationMarker.position = position
        destinationMarker.title = name
        destinationMarker.map = self.mapView
    }
    
    private func propertiesCellForRowAtIndexPath(indexPath:NSIndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("info", forIndexPath: indexPath)
        
        let key = self.properties!.allKeys[indexPath.row] as! String
        let data = self.properties![key] as? String

        cell.textLabel!.text = key
        cell.detailTextLabel!.text = data

        return cell
    }
    
    private func segmentCellForRowAtIndexPath(indexPath:NSIndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("info", forIndexPath: indexPath)
        let segment = self.route!.getMoveSegment(indexPath.row)
        
        cell.textLabel!.text = segment!.name ?? segment!.travelMode.rawValue.capitalizedString
        cell.detailTextLabel!.text = segment?.getStartTime()?.hoursAndMinuts()

        return cell
    }

    
    private func infoCellForRowAtIndexPath(indexPath:NSIndexPath)->UITableViewCell{
            let cell = tableView.dequeueReusableCellWithIdentifier("info", forIndexPath: indexPath)
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
            return cell
    }
   
   
}
