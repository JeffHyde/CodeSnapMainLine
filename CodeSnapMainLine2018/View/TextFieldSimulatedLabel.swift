//
//  TextFieldSimulatedLabel.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 7/24/18.
//  Copyright © 2018 Jeff  Hyde. All rights reserved.
//

import UIKit

class TextFieldSimulatedLabel: UILabel {
    override func awakeFromNib() {
        layer.masksToBounds = true
        layer.cornerRadius = 5.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(named: String.textFieldBorderColor)?.cgColor
    }

}
