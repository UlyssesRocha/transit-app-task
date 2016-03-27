//
//  SegmentRow.swift
//  TransitApp
//
//  Created by Ulysses on 3/27/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import WatchKit

class SegmentRow: NSObject {

    @IBOutlet var startTimeLabel: WKInterfaceLabel!
    @IBOutlet var nameLabel: WKInterfaceLabel!
    @IBOutlet var addressLabel: WKInterfaceLabel!
    
    
    func loadWithSegment(segment:Segment){
        self.nameLabel.setText(segment.name ?? segment.travelMode.rawValue.capitalizedString)
        self.addressLabel.setText(segment.segmentDescription)
        self.startTimeLabel.setText(segment.getStartTime()?.hoursAndMinuts())
    }

}
