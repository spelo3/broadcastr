//
//  RegisterInputControl.swift
//  TemplateProject
//
//  Created by Scott Pelo on 8/16/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

protocol RegisterInputControlProtocol {
    func loginComplete(user: User)
    func registrationComplete(user: User)
    func verificationCodesMatch()
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

class RegisterInputControl: UIView, UITextFieldDelegate {
    
    var delegate: RegisterInputControlProtocol!
    var avatarControl: CircleAvatarControl?
    
    var selfieImageView: UIImageView!
    var instructionsLabel: UILabel!
    var textInput: UITextField!
    var lineView: UIImage!
    var originalFrame: CGRect?
    
    var bUseAsLogin = false
    
    var user: User!
    
    private var verf_code: String!
    
    func setVerificationCode(_ verfCode: String) {
        verf_code = verfCode
    }
    
    func getVerificationCode() -> String {
        return verf_code
    }
    
    var instructionsAr = ["What Is Your Phone\nNumber?", "Choose Your\nPassword.", "Enter The Verification\nCode."]
    
    
    
    enum CurrentState {
        case login
        case phoneNumber
        case passcode
        case verification
    }
    
    var currentState: CurrentState = .phoneNumber
    
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        // Do our initialization here
        
        self.avatarControl = CircleAvatarControl(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        self.avatarControl?.setImage(image: image)
        selfieImageView = avatarControl?.imageView
        addSubview(selfieImageView)
        
        instructionsLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 275, height: 80))
        instructionsLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        instructionsLabel.textAlignment = NSTextAlignment.left
        instructionsLabel.numberOfLines = 0
        instructionsLabel.font = UIFont(name: "Avenir Next", size: 29.0)
        instructionsLabel.textColor = UIColor.init(netHex: 0x51637D)
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
                    user = User(phoneNumber: textInput.text!)
                    textInput.text = "";
                }
                break;
                
            case .passcode: textInput.text = formatAsPasscode(textInput.text! + "*")
                
                if(textInput.text!.characters.count == 8) {
                    // We've got our passcode
                    animateInAndOut()
                    currentState = .verification
                    instructionsLabel.text = instructionsAr[2];
                    user.setPasscode(passcode: textInput.text!)
                    user.setVerificationCode(verificationCode: "12345")
                    print("Passcode has been entered")
                    textInput.text = "";
                    // Send a network request to get a verification code!!
                    
                    if bUseAsLogin == true {
                        currentState = .login
                        animateUp()
                        delegate.loginComplete(user: user)
                    } else {
                        delegate.registrationComplete(user: user)
                    }
                }
                break;
                
            case .verification: textInput.text = formatAsVerificationCode(textInput.text! + digitPressed)
                
                if (textInput.text!.characters.count == 5) {
    //                Trigger the registration complete function
       
                    if (getVerificationCode() == textInput.text) {
                        print("Verification correct - Communicate to VC")
                        delegate.verificationCodesMatch()
                        animateUp()
                    } else {
                        print("All wrong, try again!")
                    }
                    textInput.text = ""
                }
                break;
            
        case .login:
            break
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
    
    func animateUp() {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 0.0
            self.originalFrame = self.frame
            let frame = self.frame
            self.frame = CGRect(x: frame.origin.x, y: 0 - frame.height, width: frame.width, height: frame.height)
        })
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


