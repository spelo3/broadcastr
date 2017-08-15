//
//  ViewController.swift
//  TemplateProject
//
//  Created by Adam Arthur on 7/25/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class WelcomeScene: UIViewController, CircleControlProtocol {
    
    var sceneState: WelcomeSceneState = WelcomeSceneState();
    var circleControl: CircleControl = CircleControl();
    var instructionsLabel: UILabel = UILabel();
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        circleControl.backgroundColor = UIColor.clear
        circleControl.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        view.addSubview(circleControl);
        
        circleControl.myDelegate = self
        
        instructionsLabel.frame = CGRect(x: 15, y: 15, width: 300, height: 50)
        instructionsLabel.text = "Insert Instructions Here"
        view.addSubview(instructionsLabel);
        
        if(sceneState.getState() == .InitialState) {
            instructionsLabel.text = "What is your name?";
            view.backgroundColor = UIColor.yellow
        }
        
        let myPanRecognizier = UIPanGestureRecognizer(target: self, action: #selector(WelcomeScene.pan))
        circleControl.addGestureRecognizer(myPanRecognizier)
    }
    
    func pan(gestureRecognizier: UIPanGestureRecognizer) {

        if gestureRecognizier.state == .began || gestureRecognizier.state == .changed {
            
            let translation = gestureRecognizier.translation(in: self.view)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizier.view!.center = CGPoint(x: gestureRecognizier.view!.center.x, y: gestureRecognizier.view!.center.y + translation.y)
            
            let currentY = gestureRecognizier.view!.center.y + translation.y
            
            circleControl.changeColor(UInt(currentY / view.bounds.maxY * 0xFFFFFF))
            
            gestureRecognizier.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetCircle(pressed: Bool) {
        print(pressed)
    }
    
    
}



// Let's override the function that is called when a user taps the screen.
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        if(sceneState.getState() == .InitialState)
//        {
//            sceneState.changeState(state: .AskingForName)
//            instructionsLabel.text = "What is your phone number?"
//            circleControl.frame = CGRect(x: 50, y: 300, width: 200, height: 200)
//            UIView.animate(withDuration: 0.3, animations: {
//                self.circleControl.frame = self.sceneState.position
//            })
//            circleControl.changeColor(0xFF5733)
//            return;
//            // If we don't return, the state's will just loop through
//        }
//
//        if(sceneState.getState() == .AskingForName)
//        {
//            sceneState.changeState(state: .AskingForPhoneNumber)
//            instructionsLabel.text = "What is your passcode?"
//            circleControl.frame = CGRect(x: 0, y: 400, width: 200, height: 200)
//            UIView.animate(withDuration: 0.3, animations: {
//                self.circleControl.frame = self.sceneState.position
//            })
//            circleControl.changeColor(0x00ffaa)
//            return;
//        }
//
//        if(sceneState.getState() == .AskingForPhoneNumber)
//        {
//            sceneState.changeState(state: .AskingForPasscode);
//            instructionsLabel.text = "I've got your name, phone number and passcode"
//            circleControl.frame = CGRect(x: 400, y: 200, width: 200, height: 200)
//            UIView.animate(withDuration: 0.3, animations: {
//                self.circleControl.frame = self.sceneState.position
//            })
//            circleControl.changeColor(0x800000)
//            return;
//        }
//
//        if(sceneState.getState() == .AskingForPasscode)
//        {
//            sceneState.changeState(state: .InitialState)
//            instructionsLabel.text = "What is your name?";
//            circleControl.frame = CGRect(x: 275, y: 400, width: 200, height: 200)
//            UIView.animate(withDuration: 0.3, animations: {
//                self.circleControl.frame = self.sceneState.position
//            })
//            circleControl.changeColor(0x10937B)
//            return;
//        }
//    }
// We are now iterate through "SceneStates" and changing elements on the screen based on the current state
// We can animate just about any property of a view
// As our animations get more complex, we'll do increasingly interesting things
// But for now, we're going to stick to simple positioning changes


