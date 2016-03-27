//
//  DataManager.swift
//  TransitApp
//
//  Created by Ulysses on 3/25/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    static let sharedInstance = DataManager()
    private override init() {}
    
    func loadRoutes(origin:String, destination:String, atTime time:NSDate?, completionHandler:(routes:[Route]?,providers:[Provider]?, error:NSError?)->()){
        
            ConnectionManager.sharedInstance.consultServerFor(origin, destination: destination, time: time, sucess: { (resultDictionary) in
                
                if let routesDictionary = resultDictionary["routes"], providersDictionary = resultDictionary["provider_attributes"]{
                    
                    var routeArray:[Route] = []
                    var providerArray:[Provider] = []
                    
                    /* Create Routes*/
                    for routeData in routesDictionary.allObjects{
                        let singleRoute = Route(dataDictionary: routeData as! [String : AnyObject])
                        routeArray.append(singleRoute)
                    }
                    /* Create Providers*/
                    for providerKey in providersDictionary.allKeys{
                        if let providerName = providerKey as? String, let providerData = providersDictionary.objectForKey(providerName) as?[String : AnyObject]{
                            let singleProvider = Provider(name: providerName, dataDictionary: providerData)
                            providerArray.append(singleProvider)
                        }
                    }
                    
                    completionHandler(routes: routeArray, providers: providerArray, error: nil)
                }
            
            }) { (error) in
                completionHandler(routes: nil,providers: nil,error: error)
            }
    }
    
}
