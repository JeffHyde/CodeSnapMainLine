//
//  TableHeaderButton.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 1/27/19.
//  Copyright © 2019 Jeff  Hyde. All rights reserved.
//

import UIKit

class TableHeaderButton: UIButton {
    convenience init(tag: Int,
                     frame: CGRect) {
        self.init(type: .infoDark)
        self.tag = tag
        self.frame = frame
        self.tintColor = .white
    }
}
