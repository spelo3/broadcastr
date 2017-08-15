//
//  UIController.swift
//  TemplateProject
//
//  Created by Adam Arthur on 7/25/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class UIController: UIViewController {
    
    var backgroundImageView: UIImageView!
    var staticImage: UIImageView!
    var startButton: UIButton!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.blue
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func setBackgroundImage(_ imageName: String) {
        let screenRect = UIScreen.main.bounds
        let background = addStaticImage(imageName, xPos: screenRect.origin.x, yPos: screenRect.origin.y, width: view.frame.width, height: view.frame.height)
        self.view.sendSubview(toBack: background)
        
    }
    
    func addStaticImage(_ imageName: String, xPos: CGFloat, yPos: CGFloat, width: CGFloat, height: CGFloat) -> UIImageView {
        let imageSize = CGRect(x: xPos, y: yPos, width: width, height: height)
        let staticImage = UIImage(named: imageName)
        let imageView = UIImageView(image: staticImage)
        
        imageView.frame = imageSize
        self.staticImage = imageView
        self.view.addSubview(imageView)
        
        return imageView
    }
    
    func addButton(_ action: Selector, buttonImage: String, xPos: CGFloat, yPos: CGFloat, width: CGFloat, height: CGFloat) -> UIButton {
        let buttonSize = CGRect(x: xPos, y: yPos, width: width, height: height)
        let button = UIButton()
        let buttonImage = UIImage(named: buttonImage)
        
        button.setImage(buttonImage, for: UIControlState.normal)
        button.frame = buttonSize
        button.addTarget(self, action: action, for: UIControlEvents.touchDown)
        self.view.addSubview(button)
        
        return button
        
    }
    
    func buttonTap() {
        
    }
    
    func createStaticText() {
        
    }
    
    func createStaticImage() {
        
    }
    
    
    
}
