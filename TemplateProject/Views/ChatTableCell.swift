//
//  ChatTableCell.swift
//  TemplateProject
//
//  Created by Scott Pelo on 9/11/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class ChatTableCell: UIView {
    
    var messageText: UILabel!
    
    private var message: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        messageText = UILabel(frame: CGRect(x: frame.width / 5, y: 0, width: (frame.width / 5) * 3, height: 30))
        messageText.font = UIFont(name: "Avenir Next", size: 29.0)
        messageText.textColor = UIColor.init(netHex: 0x51637D)
        messageText.lineBreakMode = NSLineBreakMode.byWordWrapping
        messageText.textAlignment = NSTextAlignment.left
        messageText.numberOfLines = 0
        addSubview(messageText)
        
    }
    
    func setBackground() {
        
    }
    
    func setText(_ message: String) {
        messageText.text = message
        print("setText() - messageText.text = \(message)")
    }
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
