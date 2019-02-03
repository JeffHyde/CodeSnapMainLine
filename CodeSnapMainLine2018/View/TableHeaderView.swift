//
//  TableHeaderView.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 1/27/19.
//  Copyright © 2019 Jeff  Hyde. All rights reserved.
//

import UIKit

class TableHeaderView: UIView {
    var button = TableHeaderButton()
    convenience init(section: Int,
                     frame: CGRect,
                     safeLeft: CGFloat,
                     safeWidth: CGFloat) {
        self.init(frame: frame)
        backgroundColor = UIColor(named: String.mainColor)
        let label = TableHeaderLabel(section:section,
                                     frame: CGRect(x: safeLeft + 16,
                                                   y: 0,
                                                   width: bounds.width/1.75,
                                                   height: 45))
        button = TableHeaderButton(tag: section,
                                   frame: CGRect(x: safeWidth - 43 ,
                                                 y: 0,
                                                 width: 35,
                                                 height: 45))
        addSubview(button)
        addSubview(label)
    }
}
