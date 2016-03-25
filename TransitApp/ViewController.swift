//
//  ViewController.swift
//  TransitApp
//
//  Created by Ulysses on 3/25/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.sharedInstance.loadRoutes("", destination: "", atTime: nil) { (routes, providers, error) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

