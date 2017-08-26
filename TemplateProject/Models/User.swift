//
//  User.swift
//  TemplateProject
//
//  Created by Adam Arthur on 7/25/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class User {
    
    private var phoneNumber: String!
    private var passcode: String!
    private var profileImage: UIImage!
    private var verificationCode: String!
    private var apn_identifier: String = ""
    
    required init(phoneNumber: String)
    {
        self.phoneNumber = phoneNumber
        passcode = ""
        profileImage = UIImage()
        verificationCode = "";
        apn_identifier = "";
    }
    
    convenience init(phoneNumber: String, passcode: String, profileImage: UIImage, verificationCode: String)
    {
        self.init(phoneNumber: phoneNumber)
        self.passcode = passcode
        self.profileImage = profileImage
        self.verificationCode = verificationCode
    }
    
    func setPasscode(passcode: String)
    {
        self.passcode = passcode
    }
    
    func setVerificationCode(verificationCode: String)
    {
        self.verificationCode = verificationCode
    }
    
    func getVerificationCode() -> String
    {
        return verificationCode;
    }
    
    func getUser() -> (phoneNumber: String, passcode: String, profileImage: String, apn: String)
    {
        return (phoneNumber: phoneNumber, passcode: passcode, profileImage: "", apn: apn_identifier)
    }
    
}
