//
//  LoginScene.swift
//  TemplateProject
//
//  Created by Adam Arthur on 7/25/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import Foundation

class LoginScene: RegisterScene {
    
    override func viewDidLoad() {
        addBackgroundImage()
        addInputControl()
        myInputControl.bUseAsLogin = true
        
    }
    
    override func registerUser(user: User) {
        print("The user has been registered")
    }
    
    
    
}
