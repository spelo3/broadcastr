//
//  ChatScene.swift
//  TemplateProject
//
//  Created by Scott Pelo on 8/2/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class ChatScene : UIController, MessageTableViewProtocol, CircleDragged {
    var messagesTable: MessageTableView! = nil
    var names: [String] = ["Hermione", "Harry", "Ginny", "Ron"]
    var circle: CircleControl! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTable = MessageTableView(frame: CGRect(x: 0, y: 25, width: view.frame.width, height: view.frame.height - 400))
        view.addSubview(messagesTable)
        messagesTable.delegate = messagesTable
        messagesTable.dataSource = messagesTable
        messagesTable.strings = names
        messagesTable.myDelegate = self
        
        circle = CircleControl(frame: CGRect(x: 50, y: (view.frame.width / 2) - 75, width: 150, height: 150))
        circle.backgroundColor = UIColor.clear
        circle.myDelegate = self
        view.addSubview(circle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func userSelectedHarryPotterCharacter(characterName: String, cell: UITableViewCell) {
        print("deligate fired")
        print(characterName)
        cell.textLabel?.text = "\(characterName)!"
        cell.backgroundColor = UIColor.cyan
    }
    
    func reactToCircleDragged(point: CGPoint) {
        print(point)
    }
}
