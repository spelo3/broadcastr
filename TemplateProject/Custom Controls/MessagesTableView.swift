//
//  MessagesTableView.swift
//  TemplateProject
//
//  Created by Scott Pelo on 9/6/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

class MessagesTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var chatTableCell: ChatTableCell!
    var messages: [String]! = ["default"]
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        chatTableCell = ChatTableCell()
        self.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func numberOfRows(inSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell()
        let bkColor = UIColor(red: 100, green: 0, blue: 50, alpha: 1.0)
        cell.backgroundColor = bkColor
        cell.textLabel?.font = UIFont(name: "Arial", size: 26)
        cell.addSubview(chatTableCell)
        return cell

    }
    
    

    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
