//
//  FixturesViewController.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 7/23/18.
//  Copyright © 2018 Jeff  Hyde. All rights reserved.
//

import UIKit

class FixturesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoTextView: UITextView!
    
    let cellID = CellIds.fixtures
    var totalForUI = Int16()
    var fixtures = [Fixture]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    func setUp() {
        AnimationUtility.isHiddenForAnimation(view: infoView)
        fixtures = Array<Fixture>.fixturesSorted()
        totalForUI = FixtureData.totalCount(fixtures: fixtures)
        nextButton.isEnabled = Bool.isNexButtonEnabledForFixtures(total: totalForUI)
        tableView.reloadData()
    }

    @objc func showInfoView(sender:UIButton) {
        self.view.endEditing(true)
        AnimationUtility.animateInfo(textView: infoTextView,
                                     containerView: infoView,
                                     tableView: tableView,
                                     hide: false,
                                     text: fixtures[sender.tag].information ?? "")
    }
    
    //Count Label is updated from CoreData after reload row
    @objc func addPressed(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag,
                                  section: 0)
        fixtures[indexPath.row].fixtureCount += 1
        let value = fixtures[indexPath.row].fixtureCount
        totalForUI += 1
        CoreDataHelper.saveFixtureCount(indexPath: indexPath.row,
                                        valueToSave: Int16(value))
        nextButton.isEnabled = Bool.isNexButtonEnabledForFixtures(total: totalForUI)
        tableView.reloadRows(at: [indexPath],
                             with: .none)
    }
    
    @objc func subtractPressed(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag,
                                  section: 0)
        if fixtures[indexPath.row].fixtureCount == 0 {
            CoreDataHelper.saveFixtureCount(indexPath: indexPath.row,
                                            valueToSave: Int16(0))
        } else {
            fixtures[indexPath.row].fixtureCount -= 1
            let value = fixtures[indexPath.row].fixtureCount
            totalForUI -= 1
            CoreDataHelper.saveFixtureCount(indexPath: indexPath.row,
                                            valueToSave: Int16(value))
        }
        nextButton.isEnabled = Bool.isNexButtonEnabledForFixtures(total: totalForUI)
        tableView.reloadRows(at: [indexPath],
                             with: .none)
    }
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        AnimationUtility.animateInfo(textView: infoTextView,
                                     containerView: infoView,
                                     tableView: tableView,
                                     hide: true,
                                     text: "")
    }
    

    
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Segue.result,
                     sender: self)
        AnimationUtility.animateInfo(textView: infoTextView,
                                     containerView: infoView,
                                     tableView: tableView,
                                     hide: true,
                                     text: "")
    }
}

extension FixturesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return fixtures.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: cellID,
                                                  for: indexPath) as! FixturesTableViewCell
        let data = self.fixtures[indexPath.row]
        cell.configure(data: data,
                       tag: indexPath.row)
        cell.infoButton.addTarget(self,
                                  action: #selector(showInfoView(sender:)),
                                  for: .touchUpInside)
        cell.addButton.addTarget(self,
                                 action: #selector(addPressed(sender:)),
                                 for: .touchUpInside)
        cell.subtractButton.addTarget(self,
                                      action: #selector(subtractPressed(sender:)),
                                      for: .touchUpInside)
        return cell
    }
    
}
