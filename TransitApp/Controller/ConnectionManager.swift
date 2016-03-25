//
//  ConnectionManager.swift
//  TransitApp
//
//  Created by Ulysses on 3/25/16.
//  Copyright © 2016 Ulysses Rocha. All rights reserved.
//

import UIKit

class ConnectionManager: NSObject {
    
    static let sharedInstance = ConnectionManager()
    private override init() {}

    //Mock Function, will return content of file data.json for any input
    func consultRoutesFor(source:String, destination:String, time:String, sucess:([String: AnyObject])->(), fail:(NSError?)->()){
        
            self.retrieveDataFromFile({ (jsonData) in
                
                /* Parse JSON*/
                do{
                    if let responseDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? NSDictionary{
                        
                        sucess(responseDictionary as! [String : AnyObject])
                    }
                }catch let error as NSError {
                    fail(error)
                }
                
                })
            {
                fail(nil)
        }
        
    }
    
    private func retrieveDataFromFile(sucess:(NSData)->(), fail:()->()){
        if let path = NSBundle.mainBundle().pathForResource("data", ofType: "json"){
            if let jsonData = NSData(contentsOfFile: path){
                sucess(jsonData)
            }else{
                fail()
            }
        }
    }
    

}
