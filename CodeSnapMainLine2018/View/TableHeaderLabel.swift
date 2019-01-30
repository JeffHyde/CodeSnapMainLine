//
//  TableHeaderLabel.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 1/27/19.
//  Copyright © 2019 Jeff  Hyde. All rights reserved.
//

import UIKit

class TableHeaderLabel: UILabel {
    convenience init(section: Int,
                     frame: CGRect) {
        self.init(frame: frame)
        self.textColor = .white
        self.textAlignment = .left
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.25
        self.font = UIFont.systemFont(ofSize: 18)
        self.text = ResultHeaderHelper.setText(section: section)
    }
}
