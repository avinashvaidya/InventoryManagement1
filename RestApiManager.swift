//
//  RestApiManager.swift
//  InventoryManagement1
//
//  Created by Avinash Vaidya on 6/14/15.
//  Copyright (c) 2015 Avinash Vaidya. All rights reserved.
//

import Foundation

class RestApiManager: NSObject{
    
    let session = NSURLSession.sharedSession()
    static let restSharedInstance = RestApiManager();
    let base_url = "http://localhost:8080/InventoryService/service/inventory/"
    
    func authenticateUser(loginData: LoginData, onCompletion: (Bool) -> Void){
        var err: NSError?
        var request: NSMutableURLRequest = initializeRequestObj("authenticateTech")
        var param = ["username": loginData.username!, "password":loginData.password!]
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(param, options: NSJSONWritingOptions.allZeros, error: &err)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {
            data, response, error -> Void in
            println("Response: \(response)")
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    println("response was not 200: \(response)")
                    return
                }
            }
            if (error != nil) {
                println("error submitting request: \(error)")
                return
            }
           
            var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
            if let parseJSON = result{
                if let success = parseJSON["authenticated"] as? Bool {
                    println("Success \(success)")
                    onCompletion(success)
                }
                
            }
        })
        task.resume()
        
    }
    
    
    func initializeRequestObj(serviceName: String) -> NSMutableURLRequest{
        var serviceUrl = base_url + serviceName
        var url = NSURL(string: serviceUrl)
        var request = NSMutableURLRequest(URL: url!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPMethod = "POST"
        
        return request
       
    }
    
}


