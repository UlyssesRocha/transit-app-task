//
//  RouteTableViewCell.swift
//  TransitApp
//
//  Created by Ulysses on 3/26/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import UIKit

class RouteCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate,UIWebViewDelegate {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var travelTimeLabel: UILabel!
    @IBOutlet weak var travelTimeUnitLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var arrivelTimeLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    
    @IBOutlet weak var segmentsCollectionView: UICollectionView!

    private weak var route:Route?
    
    override func prepareForReuse() {
        self.segmentsCollectionView.delegate = nil
        self.segmentsCollectionView.delegate = nil
    }
    
    func load(route:Route){
        self.route = route

        self.typeLabel.text = route.type.getName()
        
        if let price = self.route?.getPrice(){
            self.priceLabel.text = price
        }else{
            self.priceLabel.text = "Unknown"
        }
        
        self.providerLabel.text = route.provider
        self.travelTimeLabel.text = String(route.getArrivelTime()!.minutesFrom(route.getStartTime()!))
        
        self.arrivelTimeLabel.text = route.getArrivelTime()?.hoursAndMinuts()
        self.startTimeLabel.text = route.getStartTime()?.hoursAndMinuts()
        
        segmentsCollectionView.dataSource = self
        segmentsCollectionView.delegate = self
        segmentsCollectionView.reloadData()
    }
    
    
//MARK : Segments CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if route == nil{
            return 0
        }
        return route!.numberOfMoveSegments()
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let  cell = collectionView.dequeueReusableCellWithReuseIdentifier("segment", forIndexPath: indexPath) as! SegmentCell
        
        let segment = route!.getMoveSegment(indexPath.row)
        cell.nameLabel.text = segment?.name
        
        let iconURL = NSURL(string: segment!.iconUrl)
        let imageRequest = NSURLRequest(URL: iconURL!)
        
        cell.segmentImage.delegate = self
        cell.segmentImage.loadRequest(imageRequest)
        
        return cell
    }
    
    /* Workaround to solve the "invisible" SVG problem */
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.delegate = nil
        
        webView.backgroundColor = UIColor.clearColor()
        webView.opaque = false
        webView.scrollView.scrollEnabled = false
        
        let script = "var svgElement = document.getElementById('Layer_1');svgElement.style.stroke = \"#474a51\";svgElement.style.strokeWidth = 2.5;"
        webView.stringByEvaluatingJavaScriptFromString(script)
        
        let contentSize = webView.scrollView.contentSize
        let webViewsize = webView.bounds.size
        let scale = webViewsize.width/contentSize.width
        
        webView.scrollView.minimumZoomScale = scale
        webView.scrollView.maximumZoomScale = scale
        webView.scrollView.zoomScale = scale
    }
    
}
