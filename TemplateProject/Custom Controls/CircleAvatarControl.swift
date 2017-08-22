//
//  CircleAvatarControl.swift
//  TemplateProject
//
//  Created by Scott Pelo on 8/16/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class CircleAvatarControl: UIView {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        imageView.isHidden = true
        imageView.frame = self.bounds
        imageView.layer.cornerRadius = self.frame.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 10.0
        imageView.layer.borderColor = UIColor.white.cgColor
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
        imageView.isHidden = false
        print("setImage called")
    }
}
