//
//  RouteTableViewCell.swift
//  TransitApp
//
//  Created by Ulysses on 3/26/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import UIKit

class RouteTableViewCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var travelTimeLabel: UILabel!
    @IBOutlet weak var travelTimeUnitLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var segmentsCollectionView: UICollectionView!

    func load(route:Route){
        self.typeLabel.text = route.type.getName()
        
        if let price = route.amount{
            self.priceLabel.text = String(price)+" "+String(route.currency!.currencySymbol())
        }else{
            self.priceLabel.text = "Unknown"
        }
        
        self.providerLabel.text = route.provider
        self.travelTimeLabel.text = String(route.getArrivelTime()!.minutesFrom(Constants.date.toDateTime()!))
    } 
}
