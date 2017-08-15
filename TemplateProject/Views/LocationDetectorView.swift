//
//  LocationDetectorView.swift
//  TemplateProject
//
//  Created by Scott Pelo on 7/31/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class LocationDetectorView: UIViewController {
    
    var circleControl: CircleControl = CircleControl()
    var imageSide = 0
    var screenWidth: CGFloat = 0
    var screenHeignt: CGFloat = 0
    var imageWidthCenter: CGFloat = 0
    var imageHeightCenter: CGFloat = 0
    var xPosition: CGFloat = 0
    var yPosition: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "Face.png")
        let imageView = UIImageView(image: image)
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        let imageSide = screenWidth - 100
        let imageWidthCenter = CGFloat((screenWidth - imageSide) / 2)
        let imageHeightCenter = CGFloat((screenHeight - imageSide) / 2)
        
        view.backgroundColor = UIColor.darkGray
        view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        circleControl.backgroundColor = UIColor.clear
        circleControl.frame = CGRect(x: imageWidthCenter, y: imageHeightCenter, width: imageSide, height: imageSide)
        circleControl.alpha = 0.75
        view.addSubview(circleControl)
        animateCircleIn()
        
        imageView.image = image
        imageView.frame = CGRect(x: imageWidthCenter, y: imageHeightCenter, width: imageSide, height: imageSide)
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateCircleIn() {
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        let imageSide = screenWidth - 200
        let imageWidthCenter = CGFloat((screenWidth - imageSide) / 2)
        let imageHeightCenter = CGFloat((screenHeight - imageSide) / 2)

        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            
            self.circleControl.frame = CGRect(x: imageWidthCenter, y: imageHeightCenter, width: imageSide, height: imageSide)
        
        }, completion: {_ in
            self.animateCircleOut()
        })
    }

    func animateCircleOut() {
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        let imageSide = screenWidth - 100
        let imageWidthCenter = CGFloat((screenWidth - imageSide) / 2)
        let imageHeightCenter = CGFloat((screenHeight - imageSide) / 2)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            
            self.circleControl.frame = CGRect(x: (imageWidthCenter - 50), y: (imageHeightCenter - 50), width: (imageSide + 100), height: (imageSide + 100))
        
        }, completion: {_ in
            self.animateCircleIn()
        })
    }

    //        let newX: CGFloat = self.xPosition
    //        let newY: CGFloat = self.yPosition
    
    //        let newX: CGFloat = self.xPosition + imageSide/2
    //        let newY: CGFloat = self.yPosition + imageSide/2



}
