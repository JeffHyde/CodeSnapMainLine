//
//  Extensions.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 1/29/19.
//  Copyright © 2019 Jeff  Hyde. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static let alertColor = "AlertColor"
    static let mainColor = "MainColor"
    static let textFieldBorderColor = "TextFieldBorderColor"
}

extension StringProtocol {
    var double: Double? {
        return Double(self)
    }
    var float: Float? {
        return Float(self)
    }
    var integer: Int? {
        return Int(self)
    }
}

extension Notification.Name {
    static let textChanged = Notification.Name(rawValue: "TextChangedFromMeasurments")
    static let resultInfoSelected = Notification.Name(rawValue: "ResultInfoSelected")
}

extension Bool {
    /* This function enables the negative button on the Elevation textField keyboard.  See MeasurmentViewController textChangedFromCell(_:)
     */
    static func enableNegitiveButton(textField: UITextField) -> Bool  {
        if textField.text == "" {
            return true
        } else {
            return false
        }
    }
    
    /*
     This function checks for 3 values to enable the next button.
     */
    static func isNexButtonEnabledForMeasurments(measurments: [Measurements]) -> Bool {
        var countArray = [Double]()
        for item in measurments {
            //We only need to check for "-" negative value due to Elevation
            if item.value > 0.0 ||
                item.value < 0.0 {
                countArray.append(item.value)
            }
        }
        if countArray.count == 3 {
            return true
        } else {
            return false
        }
    }
    static func isNexButtonEnabledForFixtures(total: Int16) -> Bool {
        if total != 0 {
            return true
        } else {
            return false
        }
    }
    
}
