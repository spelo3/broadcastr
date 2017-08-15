//
//  CountdownSceneState.swift
//  TemplateProject
//
//  Created by Scott Pelo on 8/7/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class CountdownSceneState {
    
    enum CountdownClassState {
        case InitialState
        case One
        case Two
        case Three
    }
    
    var currentState: CountdownClassState = .InitialState
    var position = CGRect(x: 165, y: 448, width: 84, height: 197)
    
    init() {
        
    }
    
    func changeState(state: CountdownClassState) {
        currentState = state
    }
    
    func getState() -> CountdownClassState {
        return currentState
    }
}
