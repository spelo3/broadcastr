//
//  ViewController.swift
//  TemplateProject
//
//  Created by Adam Arthur on 7/25/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class WelcomeScene: UIViewController {
    
    var sceneState: WelcomeSceneState = WelcomeSceneState();
    var instructionsLabel: UILabel = UILabel();
    
    var circleControl: CircleControl = CircleControl();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleControl.backgroundColor = UIColor.clear
        circleControl.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        view.addSubview(circleControl);
        
        instructionsLabel.frame = CGRect(x: 15, y: 15, width: 300, height: 50)
        instructionsLabel.text = "Insert Instructions Here"
        view.addSubview(instructionsLabel);
        
        if(sceneState.getState() == .InitialState)
        {
            instructionsLabel.text = "What is your name?";
            view.backgroundColor = UIColor.yellow
        }
        
        let myPanRecognizier = UIPanGestureRecognizer(target: self, action: #selector(WelcomeScene.pan))
        circleControl.addGestureRecognizer(myPanRecognizier)
    }
    
    func pan(gestureRecognizier: UIPanGestureRecognizer)
    {
        print("Draggable!!!")
        if gestureRecognizier.state == .began || gestureRecognizier.state == .changed {
            
            let translation = gestureRecognizier.translation(in: self.view)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizier.view!.center = CGPoint(x: gestureRecognizier.view!.center.x + translation.x, y: gestureRecognizier.view!.center.y + translation.y)
            gestureRecognizier.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Let's override the function that is called when a user taps the screen.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(sceneState.getState() == .InitialState)
        {
            sceneState.changeState(state: .AskingForName)
            instructionsLabel.text = "What is your phone number?"
            // We're asking for the user's name
            view.backgroundColor = UIColor.green
            return;
            // If we don't return, the state's will just loop through
        }
        
        if(sceneState.getState() == .AskingForName)
        {
            sceneState.changeState(state: .AskingForPhoneNumber)
            instructionsLabel.text = "What is your passcode?"
            view.backgroundColor = UIColor.blue;
            return;
        }
        
        if(sceneState.getState() == .AskingForPhoneNumber)
        {
            sceneState.changeState(state: .AskingForPasscode);
            instructionsLabel.text = "I've got your name, phone number and passcode"
            view.backgroundColor = UIColor.brown;
            return;
        }
        
        if(sceneState.getState() == .AskingForPasscode)
        {
            sceneState.changeState(state: .InitialState)
            instructionsLabel.text = "What is your name?";
            view.backgroundColor = UIColor.yellow;
            return;
        }
    }
    
    // We are now iterate through "SceneStates" and changing elements on the screen based on the current state
    // We can animate just about any property of a view
    // As our animations get more complex, we'll do increasingly interesting things
    // But for now, we're going to stick to simple positioning changes
    
    
    
}


