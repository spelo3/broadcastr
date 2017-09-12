//
//  UIController.swift
//  TemplateProject
//
//  Created by Adam Arthur on 7/25/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class UIController: APIController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func centerWidth(width: CGFloat) -> CGFloat{
        return (view.frame.width / 2) - (width / 2)
    }
    
    func centerHeight(height: CGFloat) -> CGFloat{
        return (view.frame.height / 2) - (height / 2)
    }
    
    func addBackgroundImage(image: String = "Background.png", detailImage: String = "Combined Shape-lg.png", imageFrame: CGRect, detailImageFrame: CGRect) {
        view.addSubview(self.addStaticImage(image, frame: imageFrame))
        view.addSubview(self.addStaticImage(detailImage, frame: detailImageFrame))
    }
    
    func addBackgroundImage(image: String = "Background.png", detailImage: String = "Combined Shape-lg.png") {
        view.addSubview(self.addStaticImage(image, x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(self.addStaticImage(detailImage, x: 0, y: view.frame.height - 202, width: view.frame.width, height: 202))
    }
    
    func addButton(title: String, image: String, _ action: Selector) -> UIButton {
        let image = UIImage(named: image)
        let button = addButton(action)
        button.setBackgroundImage(image!, for: .normal)
        button.setTitle(title, for: .normal)
        return button
    }
    
    func addButton(_ action: Selector) -> UIButton {
        let button = UIButton()
        button.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        view.addSubview(button)
        return button
    }
    
    func addStaticText(text: String, frame: CGRect) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        return label
    }
    
    func addStaticImage(_ imageName: String, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UIImageView {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: x, y: y, width: width, height: height)
        return imageView
    }
    
    func addStaticImage(_ imageName: String, frame: CGRect) -> UIImageView {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = frame
        return imageView
    }
    
}
