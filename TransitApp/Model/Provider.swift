//
//  Provider.swift
//  TransitApp
//
//  Created by Ulysses on 3/25/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import Foundation

class Provider: NSObject {
    private let name:String
    private let providerIconUrl:NSURL?
    private let disclaimer:String?
    private let iosItunesUrl:NSURL?
    private let iosAppUrl:NSURL?
    private let displayName:String?
    
    init(dataDictionary:[String: AnyObject]){
        self.name = ""
        self.providerIconUrl = NSURL()
        self.disclaimer = ""
        self.iosItunesUrl = NSURL()
        self.iosAppUrl = NSURL()
        self.displayName = "test"
    }
    
}
