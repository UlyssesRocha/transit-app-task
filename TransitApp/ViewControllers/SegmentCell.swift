//
//  SegmentCell.swift
//  TransitApp
//
//  Created by Ulysses on 3/26/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import UIKit
import WebKit

class SegmentCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var segmentImage: UIWebView!
    
    override func prepareForReuse() {
        self.segmentImage.loadHTMLString("", baseURL: nil)
    }
}
