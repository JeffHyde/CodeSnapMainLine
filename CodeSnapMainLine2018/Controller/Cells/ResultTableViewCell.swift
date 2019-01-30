//
//  ResultTableViewCell.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 12/31/18.
//  Copyright © 2018 Jeff  Hyde. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
   
    func configure(section: Int,
                   indexPath:Int,
                   sizes: [String],
                   totalUnits: Double,
                   measurments: [String],
                   chosenFixtures: [Fixture]) {
        switch section {
        case 0:
            let data = sizes[indexPath]
            label.text = data
            
            if sizes.count == 1 {
                label.textColor = UIColor(named: String.alertColor)
            }else {
                label.textColor = .black
            }
        case 1:
            let data = totalUnits
            label.text = String(data)
        case 2:
            let data = measurments[indexPath]
            label.text = data
        case 3:
            let data = chosenFixtures[indexPath]
            if let name = data.name {
                label.text = "\(name) x \(data.fixtureCount)  =  \(Double(data.fixtureCount) * data.units) units"
            }
        default:
            break
        }
    }

}
