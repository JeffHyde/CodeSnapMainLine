//
//  FixturesTableViewCell.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 7/23/18.
//  Copyright © 2018 Jeff  Hyde. All rights reserved.
//

import UIKit

class FixturesTableViewCell: UITableViewCell {

    @IBOutlet var fixtureLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var subtractButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!

    func configure(data:Fixture,
                   tag:Int) {
        totalLabel.tag = tag
        addButton.tag = tag
        subtractButton.tag = tag
        infoButton.tag = tag
        if let name = data.name {
        fixtureLabel.text = "\(name)  \(data.units)"
        totalLabel.text = "\(data.fixtureCount)"
        }
        if data.fixtureCount != 0 {
            subtractButton.isEnabled = true
        } else {
            subtractButton.isEnabled = false
        }
        if data.oneAllowed == true &&
            data.fixtureCount >= 1 {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
        if data.information != nil {
            infoButton.isHidden = false
        } else {
            infoButton.isHidden = true
        }

    }
 
}
