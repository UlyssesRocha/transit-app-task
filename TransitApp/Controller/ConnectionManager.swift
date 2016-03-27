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
    
    
    //MockData
    func consultServerFor(origin:String = "", destination:String = "", time:NSDate? = nil, sucess:([String: AnyObject])->(), fail:(NSError?)->()){
        
            self.retrieveDataFromFile({ (jsonData) in
                /* Parse JSON*/
                do{
                    if let responseDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? NSDictionary{
                        sucess(responseDictionary as! [String : AnyObject])
                    }
                }catch let error as NSError {
                    fail(error)
                }})
             {
                fail(nil)
        }
    }
    
    func getDataFromUrl(url:NSURL, completionHandler:(data:NSData?,error:NSError?)->()){
        
        /*URL Settings*/
        let session = NSURLSession.sharedSession()
        let timeout = NSTimeInterval(10) // 10s
        
        let request = NSMutableURLRequest(URL: url, cachePolicy: .UseProtocolCachePolicy,timeoutInterval:timeout)
        request.HTTPMethod = "GET"
        
        /*Executing Data Request*/
        let task = session.dataTaskWithRequest(request) { (let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                completionHandler(data: nil,error: error)
                return
            }
            completionHandler(data: data, error: nil)
        }
        
        task.resume()
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
