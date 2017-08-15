//
//  CircleControl.swift
//  TemplateProject
//
//  Created by Adam Arthur on 7/26/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

protocol CircleControlProtocol {
    func resetCircle(pressed: Bool)
}

class CircleControl: UIView {
    
    var myDelegate: CircleControlProtocol?
    var circlePath = UIBezierPath()
    var color = UIColor.red
    
    
    
    override func draw(_ rect: CGRect) {
        color.setFill()
        circlePath = UIBezierPath(ovalIn: rect);
        circlePath.fill()
    }

    func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func changeColor(_ fingerPosition: UInt) {
        color = UIColorFromRGB(fingerPosition)
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myDelegate?.resetCircle(pressed: true)
    }
    

    
}
