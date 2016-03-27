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
    private let disclaimer:String?
    private let displayName:String?
    private var providerIconUrl:NSURL? = nil
    private var iosItunesUrl:NSURL? = nil
    private var iosAppUrl:NSURL? = nil

    
    init(name:String, dataDictionary:[String: AnyObject]){
        self.name = name
        self.disclaimer = dataDictionary["disclaimer"] as? String
        self.displayName = dataDictionary["display_name"] as? String
        
//        if let iconUrl = dataDictionary["provider_icon_url"] as? String{
//            self.providerIconUrl = NSURL(string: iconUrl)
//        }
//        
//        if let itunesUrl = dataDictionary["ios_itunes_url"] as? String{
//            self.iosItunesUrl = NSURL(string: itunesUrl)
//        }
//
//        if let iosUrl = dataDictionary["ios_app_url"] as? String{
//            self.iosAppUrl = NSURL(string: iosUrl)
//        }

    }
    
}
