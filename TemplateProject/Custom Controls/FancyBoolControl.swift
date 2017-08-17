//
//  FancyBoolControl.swift
//  TemplateProject
//
//  Created by Scott Pelo on 8/16/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

protocol FancyBoolDelegate {
    func actionTaken(result: Bool)
}

class FancyBoolControl: UIView {
    var delegate: FancyBoolDelegate? = nil
    
    init(point: CGPoint) {
        let size = CGSize(width: 200, height: 70)
        super.init(frame: CGRect(origin: point, size: size))
        let acceptButton = addButton(imageStr: "Accept-button.png", point: CGPoint(x: 0, y: 0), action: #selector(FancyBoolControl.accepted))
        self.addSubview(acceptButton)
        let rejectButton = addButton(imageStr: "Cancel-button.png", point: CGPoint(x: 130, y: 0), action: #selector(FancyBoolControl.rejected))
        self.addSubview(rejectButton)
        self.isHidden = true
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addButton(imageStr: String, point: CGPoint, action: Selector) -> UIButton {
        let image = UIImage(named: imageStr)
        let size = CGSize(width: 70, height: 70)
        let button = UIButton(frame: CGRect(origin: point, size: size))
        button.setImage(image, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    func showCtrl() {
        self.isHidden = false
        UIView.animate(withDuration: 0.75, animations: {
            self.alpha = 1
        })
    }
    
    func hideCtrl() {
        UIView.animate(withDuration: 0.75, animations: {
            self.alpha = 0
        })
        self.isHidden = true
    }
    
    func accepted() {
        self.delegate?.actionTaken(result: true)
    }
    
    func rejected() {
        self.delegate?.actionTaken(result: false)
    }
}
