//
//  ChatRoom.swift
//  TemplateProject
//
//  Created by Scott Pelo on 9/6/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class ChatRoom: UIController, ChatRoomTextFieldProtocol {
    
    var messagesTable: MessagesTableView! = nil
    var textField: ChatRoomTextField! = nil
    
    var messageCell: ChatTableCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatRoom.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        messagesTable = MessagesTableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 40))
        view.addSubview(messagesTable)
        messagesTable.delegate = messagesTable
        messagesTable.dataSource = messagesTable
        
        textField = ChatRoomTextField(frame: CGRect(x: 0, y: view.frame.height - 40, width: view.frame.width, height: 40))
        view.addSubview(textField)
        textField.backgroundColor = UIColor.red
        textField.myDelegate = self
        
    }
    
    func keyboardWillShow(_ notification: Notification) {
        let keyboardFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.messagesTable?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - keyboardFrame.height - 40)
        self.textField?.frame = CGRect(x: 0, y: self.view.frame.height - keyboardFrame.height - 40, width: self.view.frame.width, height: 40)
        textField.bringSubview(toFront: textField.sendButton)
    }
    
    func broadcastMessage(message: String) {
        let messageCell = ChatTableCell()
        messageCell.setText(message)
        textField.text = ""
        
        
    }
    
    func didRecvMessage() {
        
    }
}
