//
//  CircleControl.swift
//  TemplateProject
//
//  Created by Adam Arthur on 7/26/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

protocol CircleDragged {
    func reactToCircleDragged(point: CGPoint)
}

class CircleControl : UIView {
    var color: UIColor = UIColor.red
    var myDelegate: CircleDragged?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let myPanRecognizier = UIPanGestureRecognizer(target: self, action: #selector(CircleControl.pan))
        self.addGestureRecognizer(myPanRecognizier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.color.setFill()
        let circlePath = UIBezierPath(ovalIn: rect);
        circlePath.fill()
    }
    
    func pan(gestureRecognizier: UIPanGestureRecognizer) {
        if gestureRecognizier.state == .began || gestureRecognizier.state == .changed {
            let translation = gestureRecognizier.translation(in: superview)
            let point = CGPoint(x: gestureRecognizier.view!.center.x + translation.x, y: gestureRecognizier.view!.center.y + translation.y)
            gestureRecognizier.view!.center = point
            gestureRecognizier.setTranslation(CGPoint.zero, in: superview)
            self.myDelegate?.reactToCircleDragged(point: point)
        }
    }
    
}
