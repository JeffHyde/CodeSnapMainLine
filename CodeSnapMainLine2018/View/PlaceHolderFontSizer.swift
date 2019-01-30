//
//  PlaceHolderFontSizer.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 1/5/19.
//  Copyright © 2019 Jeff  Hyde. All rights reserved.
//

import Foundation
import UIKit

class AutoSizeTextField: UITextField {
    override func layoutSubviews() {
        super.layoutSubviews()
        for subview in subviews {
            if let label = subview as? UILabel {
                label.minimumScaleFactor = 0.3
                label.adjustsFontSizeToFitWidth = true
            }
        }
    }
    
}
