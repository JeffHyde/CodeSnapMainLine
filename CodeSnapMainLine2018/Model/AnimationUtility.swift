//
//  AnimationHelper.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 1/27/19.
//  Copyright © 2019 Jeff  Hyde. All rights reserved.
//

import Foundation
import UIKit

struct AnimationUtility {
    static func isHiddenForAnimation(view: UIView) {
        view.alpha = 0
        view.isHidden = true
    }
    
    static func animateInfo(textView:UITextView,
                            containerView:UIView,
                            tableView:UITableView,
                            hide:Bool,
                            text:String) {
        textView.text = text
        if hide == false {
            if containerView.isHidden {
                tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: containerView.frame.size.height, right: 0)
                containerView.alpha = 0
                containerView.isHidden = false
                UIView.animate(withDuration: 0.3,
                               delay: 0.1,
                               options: .curveEaseInOut,
                               animations: {
                    containerView.alpha = 1
                }) { (complete) in }
            }
        } else {
            tableView.contentInset = UIEdgeInsets(top: 0,
                                                  left: 0,
                                                  bottom: 0,
                                                  right: 0)
            containerView.alpha = 1
            UIView.animate(withDuration: 0.3,
                           delay: 0.1,
                           options: .curveEaseInOut,
                           animations: {
                containerView.alpha = 0
            }) { (complete) in
                containerView.isHidden = true
            }
        }
    }
    
}
