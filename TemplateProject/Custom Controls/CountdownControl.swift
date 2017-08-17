//
//  CountdownControl.swift
//  TemplateProject
//
//  Created by Scott Pelo on 8/9/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

protocol CountdownControlProtocol {
    func countdownDidEnd()
}


class CountdownControl: UIView {
    
    var myDelegate: CountdownControlProtocol?
    
    var img1: UIImageView!
    var img2: UIImageView!
    var img3: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func beginCountdown() {
        let size = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        img1 = UIImageView(image: UIImage(named: "1.png"))
        img1.frame = size
        img1.alpha = 0.0
        
        img2 = UIImageView(image: UIImage(named: "2.pnt"))
        img2.frame = size
        img2.alpha = 0.0
        
        img3 = UIImageView(image: UIImage(named: "3.png"))
        img3.frame = size
        img3.alpha = 0.0
        
        self.addSubview(img3)
        self.addSubview(img2)
        self.addSubview(img1)
        
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut, animations: {
            self.img3.alpha = 1.0
        }, completion: {_ in
            UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut, animations: {
                self.img3.alpha = 0.0
                self.img2.alpha = 1.0
            }, completion: {_ in
                UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut, animations: {
                    self.img2.alpha = 0.0
                    self.img1.alpha = 1.0
                }, completion: {_ in
                    UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut, animations: {
                        self.img1.alpha = 0.0
                    }, completion: {_ in
                        self.myDelegate?.countdownDidEnd()
                    })
                })
            })
        })
    
    }


    
    
}

