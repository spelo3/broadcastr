//
//  ChatScene.swift
//  TemplateProject
//
//  Created by Scott Pelo on 8/2/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class ChatScene: UIController, MessageTableViewProtocol {

    let messageTableView = MessageTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        let tableWidth = screenWidth - 50
        let tableHeight = tableWidth / 1.5
        let tableXPosition = CGFloat((screenWidth - tableWidth) / 2)
        let tableYPosition = (CGFloat(screenHeight - tableHeight) - tableXPosition)
        
        messageTableView.frame = CGRect(x: tableXPosition, y: tableYPosition, width: tableWidth, height: tableHeight)
        messageTableView.backgroundColor = UIColor.lightGray
        messageTableView.layer.cornerRadius = 5
        view.addSubview(messageTableView)
        
        messageTableView.myDelegate = self
        messageTableView.delegate = messageTableView
        messageTableView.dataSource = messageTableView
        messageTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func userSelectedHarryPotterCharacter(characterName: String) {
        print(characterName)
    }


}

