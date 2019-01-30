//
//  AlertUtility.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 7/26/18.
//  Copyright © 2018 Jeff  Hyde. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class AlertUtility {
    static func alert(title:String,
                      message:String,
                      view:UIViewController) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { (action) in }
        alert.addAction(okAction)
        view.present(alert, animated: true, completion: nil)
    }
  
}




//MARK: - TODO
//extension UIViewController: MFMailComposeViewControllerDelegate {
//
//    private func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true) {
//        }
//    }
//
//    static func send() {
//        if MFMailComposeViewController.canSendMail() {
//            let mail = MFMailComposeViewController()
//            mail.mailComposeDelegate = self
//            mail.setToRecipients(["magnitudecompany@gmail.com"])
//            mail.setMessageBody("Code Snap Main Line Is Not Saving", isHTML: true)
//            delegate.present(mail, animated: true) {
//
//            }
//        }
//    }
//}
