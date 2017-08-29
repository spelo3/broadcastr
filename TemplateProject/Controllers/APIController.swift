//
//  APIController.swift
//  TemplateProject
//
//  Created by Adam Arthur on 7/25/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

class APIController: NetworkController {
    
    func registerUser(user: User) {
        httpVerb = "POST"
        setResource("users")
        addParameter("phone_num", value: user.getUser().phoneNumber as AnyObject)
        addParameter("passcode", value: user.getUser().passcode as AnyObject)
        addParameter("apn_identifier", value: "" as AnyObject)
        addParameter("verf_code", value: user.getVerificationCode() as AnyObject)
        networkRequest(registerUserResult)
    }
    
    func registerUserResult(_ jsonStr: JSON) {
        // This function intended to be overwritten
        print(jsonStr)
    }
    
    func loginUser(user: User) {
        httpVerb = "POST"
        setResource("login")
        addParameter("phone_num", value: user.getUser().phoneNumber as AnyObject)
        addParameter("passcode", value: user.getUser().passcode as AnyObject)
        networkRequest(loginUserResult)
    }
    
    func loginUserResult(_ jsonStr: JSON) {
        // This function intended to be overwritten
        print(jsonStr)
    }
    
    
    
    
}


