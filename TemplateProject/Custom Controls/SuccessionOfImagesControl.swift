//
//  SuccessionOfImagesControl.swift
//  TemplateProject
//
//  Created by Scott Pelo on 8/16/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit
import Foundation

protocol SuccessionOfImagesDelagate {
    func runCompleted()
}

class SuccessionOfImagesControl: UIView {
    var images: Array<String>
    var imageView: UIImageView
    var delagate: SuccessionOfImagesDelagate? = nil
    
    init(frame: CGRect, imagesArray: Array<String>) {
        self.images = imagesArray
        imageView = UIImageView()
        super.init(frame: frame)
        
        imageView.frame = self.bounds
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            self.imageView.image = self.imageAt(index: 0)
            self.alpha = 1
        }, completion: {finished in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                self.alpha = 0
            }, completion: {finished in
                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                    self.imageView.image = self.imageAt(index: 1)
                    self.alpha = 1
                }, completion: {finished in
                    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                        self.alpha = 0
                    }, completion: {finished in
                        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                            self.imageView.image = self.imageAt(index: 2)
                            self.alpha = 1
                        }, completion: {finished in
                            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                                self.alpha = 0
                            }, completion: {_ in
                                self.delagate?.runCompleted()
                            })
                        })
                    })
                })
            })
        })
    }
    
    func imageAt(index: Int) -> UIImage {
        return UIImage(named: self.images[index])!
    }
}
