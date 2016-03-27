//
//  InfoRow.swift
//  TransitApp
//
//  Created by Ulysses on 3/27/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import WatchKit

class DetailRow: NSObject {

    @IBOutlet var detailLabel: WKInterfaceLabel!
    @IBOutlet var infoLabel: WKInterfaceLabel!
    
    func loadWithDictionary(key:String, data:String){
        self.infoLabel.setText(key)
        self.detailLabel.setText(data)
    }
}
