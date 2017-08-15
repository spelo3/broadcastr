//
//  RegisterScene.swift
//  TemplateProject
//
//  Created by Scott Pelo on 8/7/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit



class RegisterScene: UIController, CountdownControlProtocol {
    
    var countdownControl: CountdownControl!
    var hamburger: UIButton!
    var infoButton: UIButton!
    var countdownButton: UIButton!
    var profilePicture: UIImageView!
    var clouds: UIImageView!
    
    
    override func viewDidLoad() {
        
        setBackgroundImage("Background.png")
        clouds = addStaticImage("Combined Shape-lg.png", xPos: 0, yPos: 534, width: 414, height: 202)
        hamburger = addButton(#selector(UIController.buttonTap), buttonImage: "Menue-icon.png", xPos: 23, yPos: 23, width: 22, height: 22)
        infoButton = addButton(#selector(UIController.buttonTap), buttonImage: "info-icon.png", xPos: 369, yPos: 23, width: 22, height: 22)
        countdownButton = addButton(#selector(RegisterScene.countdownButtonPressed), buttonImage: "CountDown-button.png", xPos: 92, yPos: 479, width: 230, height: 50)
        profilePicture = addStaticImage("Camera-img1.png", xPos: 70, yPos: 128, width: 275, height: 275)
        
        countdownControl = CountdownControl(frame: CGRect(x: 165, y: 448, width: 84, height: 197));
        countdownControl.delegate = self
        
    }
    
    func countdownButtonPressed() {
        countdownButton.isHidden = true
        view.addSubview(countdownControl)
        countdownControl.beginCountdown()
        
    }
    
    func countdownDidEnd() {
        print("pressed")
    }

    
    
    
}

