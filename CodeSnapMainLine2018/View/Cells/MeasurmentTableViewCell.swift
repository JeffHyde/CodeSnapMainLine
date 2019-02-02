//
//  MeasurmentTableViewCell.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 1/12/19.
//  Copyright © 2019 Jeff  Hyde. All rights reserved.
//

import UIKit

class MeasurmentTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var infoButton: UIButton!
    
    var negitiveButton = UIBarButtonItem()
    var orderIndex = Int16()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    func configure(data:Measurements, tag: Int) {
        orderIndex = data.orderIndex
        typeLabel.text = data.title
        textField.placeholder = data.placeHolderText
        textField.tag = tag
        infoButton.tag = tag
        if data.value != 0 {
            textField.text = String(Int(data.value))
        }
        if data.requiresNegative == true {
            textField.inputAccessoryView = keyBoardToolBar()
        }
    }
    
    func keyBoardToolBar()-> UIToolbar {
        let flexableSpace = KeyboardHelper.toolBarItem(type: .flexibleSpace,
                                                       viewController: self,
                                                       action: nil)
        negitiveButton = UIBarButtonItem(title: "Negitive -",
                                         style: .done,
                                         target: self,
                                         action: #selector(addNegitive))
        negitiveButton.tintColor = .white
        let toolBar = KeyboardHelper.toolBar(items: [
            flexableSpace,
            negitiveButton,
            flexableSpace
            ])
        toolBar.isTranslucent = true
        toolBar.barStyle = .blackTranslucent
        return toolBar
    }
    @objc func addNegitive() {
        negitiveButton.isEnabled = false
        textField.text?.append("-")
    }
    
    
    @IBAction func textFieldTouched(_ sender: UITextField) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func textFieldDidChangeText(_ sender: UITextField) {
        if sender.text == "" {
            negitiveButton.isEnabled = true
            NotificationCenter.default.post(Notification(name: Notification.Name.textChanged,
                                                         object: nil,
                                                         userInfo: [
                                                            "sender": sender,
                                                            "orderIndex": self.orderIndex,
                                                            "value": "empty"
                ]))
        } else {
            negitiveButton.isEnabled = false
            print("Sender Text: \(String(describing: sender.text?.double))")
            if let value = sender.text?.double {
                print("OrderIndex Of Text Field \(self.orderIndex)")
                NotificationCenter.default.post(Notification(name: Notification.Name.textChanged,
                                                             object: nil,
                                                             userInfo: [
                                                                "sender":sender,
                                                                "orderIndex": self.orderIndex,
                                                                "value": value
                    ]))
            } else {
                //Do nothing.  We handle this while the user is typing and we check for a double <0 & >0
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        negitiveButton.isEnabled = Bool.enableNegitiveButton(textField: textField)
    }
}
