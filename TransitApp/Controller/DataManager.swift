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
                for route in routesDictionary.allObjects{
                    let testRoute = Route(dataDictionary: route as! [String : AnyObject])
                    routeArray.append(testRoute)
                }
                
                for provider in providersDictionary.allObjects{
                    
                }

            }
            
           
            
            
            }) { (error) in
                completionHandler(routes: nil,providers: nil,error: error)
        }
    }
    

}
