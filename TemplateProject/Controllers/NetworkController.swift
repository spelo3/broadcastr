//
//  NetworkController.swift
//  TemplateProject
//
//  Created by Adam Arthur on 7/25/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class NetworkController : UIController {
    
    var urlResource = "" // Network API URL Goes here
    
    var httpBody: String = ""
    var httpVerb: String = "POST";
    
    var jsonDataObj = [String : AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayLoading() {
    
    }
    
    func hideLoading() {
    
    }
    
    // This is expected to be called by a subclass
    func setResource(_ urlResource: String) {
        self.urlResource = urlResource
    }
    
    func addParameter(_ parameter: String, value: AnyObject) {
        jsonDataObj[parameter] = value
    }
    
    func resetJsonObj() {
        jsonDataObj.removeAll()
        
    }
    
    func networkRequest(_ completion: @escaping (JSON) -> Void) {
        networkRequest(completion, timeout: timeout)
    }
    
    func networkRequest(_ completion: @escaping (JSON) -> Void, timeout: @escaping () -> Void) {
        let params = jsonDataObj
        // This class is intended to be used exclusively for a RESTFUL Web Service that uses JSON as
        // its message format
        
        // That means we can expect to make POST, PUT, PATCH, DELETE calls etc
        // In general, our message bodies will look something like this:
        /*
         {
         "Parameter":"Value",
         "Parameter1":"Value1"
         }
         */
        // This code allows us to easily setup and configure RESTFUL calls that use this
        // method.  It's fairly common and many if not most new API's will use something similar
        // Our "parameters" are stored in the object we created above, jsonDataObj
        
        let request = NSMutableURLRequest(url: URL(string: urlResource)!)
        // this request object is what we use to configure our HTTP Session
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // this sets our HTTP Header to "application/json" -- we would change this
        // to whatever our API expected
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = httpVerb
        // There are many HTTP Verb' we might use, but the most common are POST, PUT, PATCH and DELETE
        
        request.timeoutInterval = 10
        // This is the timeout parameter
        
        if ((httpVerb == "POST") || (httpVerb == "PUT") || (httpVerb == "PATCH")) {
            do {
                
                let jsonData = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
                // This converts our jsonData object to a JSON format that is usable
                
                //Convert back to string. Usually only do this for debugging
                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    print(JSONString)
                }
                
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
                
            } catch {
                print(error)
            }
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler:
            // This line initiates our URL session in a seperate thread
            {
                data, response, error in
                
                if error != nil {
                    DispatchQueue.main.async(execute: {
                        // Because our data tasks are performed in a seperate thread,
                        // any time we want to interact with the user interface, we need to "sync"
                        // with the main thread.  That's what this line of code does.
                        timeout()
                    })
                } else {
                    let json = JSON(data: data!)
                    // This takes our response and loads it into a JSON object that we can use
                    
                    DispatchQueue.main.async(execute: {
                        self.hideLoading()
                        completion(json)
                        // This calls our completion handler
                    })
                }
        })
        
        task.resume()
        self.displayLoading()
    }
    
    func timeout() {
        // This function is called if the data task times out.
    }
}
