//
//  WelcomeScene.swift
//  TemplateProject
//
//  Created by Adam Arthur on 7/25/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//


//  When creating animation-heavy applications, managing the different 'states' can become unwieldly..
//  We're not going to do full on Scene's here.  This is a personal preference for organizing a project
//  Employers or coder's may have difference preferences

//  Whenever we deviate from best practices or standards -- and there really aren't any official
//  Project organization standards for iOS -- we want to make sure our reasoning is logical, and
//  that an experienced developer could look at our project and notes and follow along.

//  In this case, we're going to have a WelcomeScene, and we're going to model the different states
//  in a model class.  We'll create an instances of this model in the WelcomeScene

import UIKit

class WelcomeSceneState {

    enum WelcomeClassState {
        case InitialState
        case AskingForPhoneNumber
        case AskingForPasscode
        case AskingForName
    }
    
    var currentState: WelcomeClassState = .InitialState
    var position = CGRect(x: 100, y: 300, width: 50, height: 50)
    
    init() {
        
    }
    
    // Now, we've got some options here.
    // We can create "getter" and "setter" functions to manage the current state
    // of the app
    
    // There's an old programmer's joke.  What's the difference between a senior software engineer
    // and a junior software engineer?
    
    // Anyway, let's create a function that changes the current state.
    func changeState(state: WelcomeClassState)
    {
        
        currentState = state;
    }
    
    // We also want to create a 'getter' function
    func getState() -> WelcomeClassState
    {
        return currentState
    }
    // Sometimes XCode get's ahead of itself...
    
    // When managing animation-heavy applications, there are two basic types of positioning data we'll be dealing
    // with.  One type is static positioning -- where we have elementX at CGRect(0, 0, 50, 50) at InitialState,
    // whereas elementX is at CGRect(50, 50, 50, 50) at AskingForPhoneNumber
    
    // There are laos dynamic positioning.  An example of this is if you are using touch, and the elements 
    // on the screen respond to the touch.  We'll cover this later, as there is a different approach
    // to handling this.  For now, our animations are going to be relatively simple
    
    // We'll come back to this class as we begin to implement our WelcomeScene.
    
    
}
