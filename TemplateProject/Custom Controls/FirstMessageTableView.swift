//
//  FirstMessageTableView.swift
//  TemplateProject
//
//  Created by Scott Pelo on 8/2/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit

protocol FirstMessageTableViewProtocol {
    func userSelectedHarryPotterCharacter(characterName: String, cell: UITableViewCell)
}

class FirstMessageTableView : UITableView, UITableViewDelegate, UITableViewDataSource {
    var strings: [String] = ["default"]
    var myDelegate: FirstMessageTableViewProtocol?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FirstMessageTableView.tapName))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfRows(inSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.dequeueReusableCell(withIdentifier: "cell")!
        let bkColor = UIColor(red: 196/255, green: 209/255, blue: 148/255, alpha: 1.0)
        cell.textLabel?.text = self.strings[indexPath.section]
        cell.backgroundColor = bkColor
        cell.textLabel?.font = UIFont(name: "Arial", size: 26)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return strings.count
    }
    
    func tapName(recognizer: UITapGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.ended {
            let tapLocation = recognizer.location(in: self)
            if let tapIndexPath = self.indexPathForRow(at: tapLocation) {
                if let tappedCell = self.cellForRow(at: tapIndexPath) {
                    self.myDelegate?.userSelectedHarryPotterCharacter(characterName: (tappedCell.textLabel?.text)!, cell: tappedCell)
                }
            }
        }
    }
}

