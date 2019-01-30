//
//  HeightViewController.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 7/22/18.
//  Copyright © 2018 Jeff  Hyde. All rights reserved.
//

import UIKit
import SafariServices
import CoreData

class MeasurmentViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoTextView: UITextView!
    
    var measurments = [Measurements]()
    let cellID = CellIds.measurments
    var negitiveButton = UIBarButtonItem()
    var toolBar = UIToolbar()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AnimationUtility.isHiddenForAnimation(view: infoView)
        tableView.tableFooterView = UIView()
        fetchData(completion: {
            DispatchQueue.main.async {
            self.tableView.reloadData()
            self.nextButton.isEnabled = Bool.isNexButtonEnabledForMeasurments(measurments: self.measurments)
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textChangedFromCell(_:)),
                                               name: Notification.Name.textChanged,
                                               object: nil)
        navigationController?.navigationBar.tintColor = .white
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func fetchData(completion: @escaping ()->()) {
        self.measurments = Array<Measurements>.measurmentsSorted()
        completion()
    }
  
    @objc func textChangedFromCell(_ notification:Notification) {
        /*
         This function is used when a user types into a UITextField, checks for nil text and saves to CoreData.
        */
        if let sender = notification.userInfo?["sender"] as? UITextField,
            let orderIndex = notification.userInfo?["orderIndex"] as? Int16,
            let value = notification.userInfo?["value"] as? Double {
            // text is Double
            CoreDataHelper.saveMeasurementValue(indexPath: orderIndex,
                                                valueToSave: value)
            negitiveButton.isEnabled = Bool.enableNegitiveButton(textField: sender)
            fetchData(completion: {
                self.nextButton.isEnabled = Bool.isNexButtonEnabledForMeasurments(measurments: self.measurments)
            })
        } else {
            //empty text
            if let sender = notification.userInfo?["sender"] as? UITextField,
                let orderIndex = notification.userInfo?["orderIndex"] as? Int16,
                let _ = notification.userInfo?["value"] as? String {
                //Text is a string so we cant check for nil,   hence the "_" for value
                CoreDataHelper.saveMeasurementValue(indexPath: orderIndex,
                                                    valueToSave: Double())
                negitiveButton.isEnabled = Bool.enableNegitiveButton(textField: sender)
                fetchData(completion: {
                    self.nextButton.isEnabled = Bool.isNexButtonEnabledForMeasurments(measurments: self.measurments)
                })
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        AnimationUtility.animateInfo(textView: infoTextView,
                                     containerView: infoView,
                                     tableView: tableView,
                                     hide: true, text: "")
        tableView.contentInset = UIEdgeInsets(top: 0,
                                              left: 0,
                                              bottom: keyboardFrame.height + 40,
                                              right: 0)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        tableView.contentInset = UIEdgeInsets(top: 0,
                                              left: 0,
                                              bottom: 0,
                                              right: 0)
    }
    
    @objc func showInfoView(sender:UIButton) {
        self.view.endEditing(true)
        AnimationUtility.animateInfo(textView: infoTextView,
                                     containerView: infoView,
                                     tableView: tableView,
                                     hide: false,
                                     text: measurments[sender.tag].information ?? "")
    }
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        AnimationUtility.animateInfo(textView: infoTextView,
                                     containerView: infoView,
                                     tableView: tableView,
                                     hide: true,
                                     text: "")
    }
    
    @IBAction func sourceButtonPressed(_ sender: UIBarButtonItem) {
        let link = LinksData.sourceLink.link
        if let url = URL(string:link) {
            let vc = SFSafariViewController(url: url,
                                            configuration: .init())
            present(vc, animated: true,
                    completion: nil)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
        AnimationUtility.animateInfo(textView: infoTextView,
                                     containerView: infoView,
                                     tableView: tableView,
                                     hide: true,
                                     text: "")
        resignFirstResponder()
        performSegue(withIdentifier: Segue.fixtures,
                     sender: self)
    }

}

extension MeasurmentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return measurments.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID ,
                                                 for: indexPath) as! MeasurmentTableViewCell
        let data = measurments[indexPath.row]
        cell.configure(data: data,
                       tag: indexPath.row)
        cell.infoButton.addTarget(self,
                                  action: #selector(showInfoView(sender:)),
                                  for: .touchUpInside)
        return cell
    }
    
}
