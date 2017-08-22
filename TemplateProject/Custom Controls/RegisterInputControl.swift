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

class RegisterInputControl: UIView, UITextFieldDelegate {
    
    var delegate: RegisterInputControlProtocol!
    
    var selfieImageView: UIImageView!
    var selfieImage: UIImage!
    var instructionsLabel: UILabel!
    var textInput: UITextField!
    var lineView: UIImage!
    var originalFrame: CGRect?
    
    var instructionsAr = ["What is your Phone Number?", "Choose a 4-Digit Passcode", "Enter the Verification Code"]
    
    enum CurrentState {
        case phoneNumber
        case passcode
        case verification
    }
    
    var currentState: CurrentState = .phoneNumber
    
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        // Do our initialization here
        
        
        selfieImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        selfieImage = image
        selfieImageView.image = selfieImage
        addSubview(selfieImageView)
        
        instructionsLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 275, height: 80))
        instructionsLabel.text = instructionsAr[0]
        addSubview(instructionsLabel)
        
        textInput = UITextField(frame: CGRect(x: 0, y: 200, width: 275, height: 35))
        textInput.keyboardType = .numberPad
        textInput.delegate = self
        lineView = UIImage(named: "Input-fill.png")
        let lineImageView = UIImageView(image: lineView)
        lineImageView.frame = CGRect(x: 0, y: textInput.frame.height - 1, width: 300, height: 1)
        textInput.addSubview(lineImageView)
        addSubview(textInput)
        textInput.becomeFirstResponder()
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        keypadDigitPressed(string)
        
        return false
    }
    
    func keypadDigitPressed(_ digitPressed: String) {
        var digitPressed = digitPressed
        // A keypad digit was pressed, update the text field!
        let char = digitPressed.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if isBackSpace == -92 {
            textInput.text = ""
            digitPressed = ""
            return
        }
        
        switch(currentState) {
        case .phoneNumber: textInput.text = formatAsPhone(textInput.text! + digitPressed)
            
            if(textInput.text?.characters.count == 14) {
                animateInAndOut()
                currentState = .passcode;
                instructionsLabel.text = instructionsAr[1]
                textInput.text = "";
            }
            break;
            
        case .passcode: textInput.text = formatAsPasscode(textInput.text! + "*")
            
            if(textInput.text!.characters.count == 8) {
                // We've got our passcode
                animateInAndOut()
                currentState = .verification;
                instructionsLabel.text = instructionsAr[2];
                textInput.text = "";
                // Send a network request to get a verification code!!
            }
            break;
            
        case .verification: textInput.text = formatAsVerificationCode(textInput.text! + digitPressed)
            
            if(textInput.text!.characters.count == 5) {
                animateInAndOut()
                // Trigger the registration complete function
                delegate.registrationComplete(verificationCode: "")
                removeFromSuperview()
            }
            break;
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func animateInAndOut() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .allowAnimatedContent, animations: {
            self.alpha = 0.0
            let frame = self.frame
            self.originalFrame = frame
            self.frame = CGRect(x: 0 - frame.width, y: frame.origin.y, width: frame.width, height: frame.height)
        })
        
        UIView.animate(withDuration: 0.5, delay: 1, options: .allowAnimatedContent, animations: {
            self.frame = self.originalFrame!
            self.alpha = 1.0
        }, completion: nil)
    }
    
    func formatAsPhone(_ formatString: String) -> String {
        let stringLength = formatString.characters.count
        
        if(stringLength == 1) {
            return "(" + formatString
        }
        
        if(stringLength == 4) {
            return formatString + ") "
        }
        
        if(stringLength == 9) {
            return formatString + "-"
        }
        
        return formatString
    }
    
    func formatAsPasscode(_ formatString: String) -> String {
        return formatString + " "
    }
    
    func formatAsVerificationCode(_ formatString: String) -> String {
        return formatString
    }
    
    
}


//    func animateUp() {
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
//            self.alpha = 0.0
//            self.originalFrame = self.frame
//            let frame = self.frame
//            self.frame = CGRect(x: frame.origin.x, y: 0 - frame.height, width: frame.width, height: frame.height)
//        })
//    }
