//
//  MessageTableView.swift
//  TemplateProject
//
//  Created by Scott Pelo on 8/2/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

protocol MessageTableViewProtocol {
    func userSelectedHarryPotterCharacter(characterName: String)
}

class MessageTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var myDelegate: MessageTableViewProtocol?
    var names: [String] = ["Hermione", "Harry", "Ginny", "Ron"]

    override func numberOfRows(inSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = dequeueReusableCell(withIdentifier: "cell")!
        let bkColor = UIColor(red: 196/255, green: 209/255, blue: 148/255, alpha: 1.0)
        cell.textLabel?.text = self.names[indexPath.section]
        cell.backgroundColor = bkColor
        cell.textLabel?.font = UIFont(name: "Arial", size: 26)
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myDelegate?.userSelectedHarryPotterCharacter(characterName: names[indexPath.section])
    }

}

