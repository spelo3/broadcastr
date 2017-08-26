//
//  RegisterScene.swift
//  TemplateProject
//
//  Created by Scott Pelo on 8/7/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class RegisterScene: UIController, SuccessionOfImagesDelagate, FancyBoolDelegate, CameraControlDelegate, RegisterInputControlProtocol {
    
    var countdownButton: UIButton? = nil
    var countdownImages: Array<String> = ["3.png", "2.png", "1.png"]
    var countdownCtrl: SuccessionOfImagesControl? = nil
    var acceptCtrl: FancyBoolControl? = nil
    var cameraCtrl: CameraControl?
    var avatarControl: CircleAvatarControl?
    var myInputControl: RegisterInputControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackgroundImage()
        countdownButton = addCountdownButton(frame: CGRect(x: (view.frame.width / 2) - 115, y: view.frame.height * 0.6, width: 230, height: 50))
        countdownCtrl = SuccessionOfImagesControl(frame: CGRect(x: (view.frame.width / 2) - 50, y: view.frame.height * 0.6, width: 100, height: 150), imagesArray: self.countdownImages)
        countdownCtrl?.delagate = self
        view.addSubview(countdownCtrl!)
        self.acceptCtrl = FancyBoolControl(point: CGPoint(x: (view.frame.width / 2) - 100, y: view.frame.height * 0.6))
        acceptCtrl?.isHidden = true
        acceptCtrl?.delegate = self
        view.addSubview(acceptCtrl!)
        self.cameraCtrl = CameraControl(frame: CGRect(x: centerWidth(width: 300), y: -300, width: 300, height: 300))
        self.cameraCtrl?.delegate = self
        view.addSubview(cameraCtrl!)
        self.avatarControl = CircleAvatarControl(frame: CGRect(x: self.centerWidth(width: 300), y: self.view.frame.height * 0.1, width: 300, height: 300))
        self.avatarControl?.isHidden = true
        view.addSubview(self.avatarControl!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addCountdownButton(frame: CGRect) -> UIButton {
        let button = addButton(title: "Start Countdown", image: "count-down-button-bg", #selector(RegisterScene.tapStartCountdown))
        button.frame = CGRect(x: (view.frame.width / 2) - 115, y: view.frame.height * 0.6, width: 230, height: 50)
        return button
    }
    
    func showCameraView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.cameraCtrl?.frame = CGRect(x: self.centerWidth(width: 300), y: self.view.frame.height * 0.1, width: 300, height: 300)
        })
    }
    
    func hideAvatarView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.avatarControl?.frame = CGRect(x: self.centerWidth(width: 300), y: -300, width: 300, height: 300)
        }, completion: {_ in
            self.avatarControl?.isHidden = true
            self.avatarControl?.frame = CGRect(x: self.centerWidth(width: 300), y: self.view.frame.height * 0.1, width: 300, height: 300)
        })
    }
    
    func tapStartCountdown() {
        self.showCameraView()
        UIView.animate(withDuration: 0.75, animations: {
            self.countdownButton?.alpha = 0
        }, completion: {_ in self.countdownCtrl?.startAnimation()})
    }
    
    func runCompleted() {
        self.cameraCtrl?.captureImage()
        self.acceptCtrl?.showCtrl()
    }
    
    func actionTaken(result: Bool) {
        self.acceptCtrl?.hideCtrl()
        if result {
            addInputControl()
        } else {
            self.cameraCtrl?.initializeCamera()
            self.hideAvatarView()
            view.addSubview(self.cameraCtrl!)
            UIView.animate(withDuration: 0.75, animations: {
                self.countdownButton?.alpha = 1
            })
        }
    }
    
    func getImage(image: UIImage) {
        self.avatarControl?.setImage(image: image)
        self.avatarControl?.isHidden = false
        self.cameraCtrl?.removeFromSuperview()
        self.cameraCtrl?.frame = CGRect(x: centerWidth(width: 300), y: -300, width: 300, height: 300)
    }
    
    func addInputControl() {
        hideAvatarView()
        
        myInputControl = RegisterInputControl(frame: CGRect(x: 59, y: 100, width: view.frame.width - 100, height: 350), image: (avatarControl?.imageView.image)!)
        myInputControl.delegate = self
        view.addSubview(myInputControl)
    }
    
    func registrationComplete(user: User) {
        // Registration is complete
        print("API Call here")
        user.setVerificationCode(verificationCode: "12345")
        myInputControl.setVerificationCode("12345")
        registerUser(user: user)
    }
    
    func verificationCodesMatch() {
        myInputControl.animateUp()
    }
    
    override func registerUserResult(_ jsonStr: JSON) {

        if jsonStr["Error"].int != nil {
            print("we received a response")
            let errorNumber = jsonStr["Error"].int
            if errorNumber == 0 {
                print("The user registered")
            } else if errorNumber == 506 {
                // The user has already registered
                // From here we would navigate to login control
                myInputControl.animateUp()
            } else {
                print(jsonStr["ErrorDetails"]["Error Description"])
            }
                
        }
    }



}

