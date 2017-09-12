//
//  ChatRoomTextField.swift
//  TemplateProject
//
//  Created by Scott Pelo on 9/6/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

protocol ChatRoomTextFieldProtocol {
    func broadcastMessage(message: String)
}

class ChatRoomTextField: UITextField {
    
    var myDelegate: ChatRoomTextFieldProtocol?
    var sendButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        sendButton = UIButton(frame: CGRect(x: frame.width - 40, y: frame.height - 35, width: 30, height: 30))
        sendButton.addTarget(self, action: #selector(ChatRoomTextField.send), for: .touchUpInside)
        sendButton.backgroundColor = UIColor.blue
        addSubview(sendButton)
        
    }
    
    func send() {
        self.myDelegate?.broadcastMessage(message: self.text!)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
