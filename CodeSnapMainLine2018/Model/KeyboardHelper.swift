//
//  KeyboardHelper.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 1/29/19.
//  Copyright © 2019 Jeff  Hyde. All rights reserved.
//

import Foundation
import UIKit

struct KeyboardHelper {
    static func containerView(width:CGFloat) -> UIView {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: width,
                                        height: 80))
        return view
    }
    
    static func textFiled(placeHolder:String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeHolder
        textField.keyboardType = .numberPad
        return textField
    }
    static func toolBar(items:[UIBarButtonItem]) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.items = items
        return toolbar
    }
    static func toolBarItem(type:UIBarButtonItem.SystemItem,
                            viewController: Any,
                            action: Selector?) -> UIBarButtonItem {
        let button = UIBarButtonItem(barButtonSystemItem: type,
                                     target: viewController,
                                     action: action)
        button.tintColor = UIColor(named: String.mainColor)
        return button
    }
    
}
