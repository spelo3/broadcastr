//
//  RegisterInputControl.swift
//  TemplateProject
//
//  Created by Scott Pelo on 8/16/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

protocol RegisterInputControlProtocol {
    func registrationComplete(verificationCode: String) -> (phone: String, passcode: String)
    
}

class RegisterInputControl: UIView {
    
    var delegate: RegisterInputControlProtocol!
    
    var selfieImage: UIImage!
    var instructionLabel: UILabel!
    var lineView: UIImage!
    var textInput: UITextField!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Do our initialization here
        
        backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
