//
//  ResultsViewController.swift
//  CodeSnapMainLine2018
//
//  Created by Jeff  Hyde on 7/25/18.
//  Copyright © 2018 Jeff  Hyde. All rights reserved.
//

import UIKit
import SafariServices

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoTextView: UITextView!
    
    let cellID = CellIds.result
    
    var chosenFixtures = [Fixture]()
    var measurmentModel = [Measurements]()
    var actualPSI = Double()
    var sizes = [String]()
    var measurments = [String]()
    var totalUnits = Double()
    var data = ResultData()
    
    private var safeLeft = CGFloat()
    private var safeWidth = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnimationUtility.isHiddenForAnimation(view: infoView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AnimationUtility.animateInfo(textView: infoTextView,
                                     containerView: infoView,
                                     tableView: tableView,
                                     hide: true,
                                     text: "")
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpLayoutGuide()
    }
   
    //Used to maintain tableview header content inset with layoutGuide on rotation
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setUpLayoutGuide() {
        let guide = view.safeAreaLayoutGuide
        safeWidth = guide.layoutFrame.size.width
        safeLeft = view.safeAreaInsets.left
    }
    
    @objc func showInfo(_ sender:UIButton) {
        AnimationUtility.animateInfo(textView: infoTextView,
                                     containerView: infoView,
                                     tableView: tableView,
                                     hide: false,
                                     text: ResultInfo.data[sender.tag])
    }
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        AnimationUtility.animateInfo(textView: infoTextView,
                                     containerView: infoView,
                                     tableView: tableView,
                                     hide: true,
                                     text: "")
    }
    
    @IBAction func sourceButtonPressed(_ sender: UIBarButtonItem) {
        let link = LinksData.sourceLink.link
        if let url = URL(string:link) {
            let safariViewController = SFSafariViewController(url: url,
                                                              configuration: .init())
            present(safariViewController,
                    animated: true,
                    completion: nil)
        }
    }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return data.sizes.count
        case 1:
            return 1
        case 2:
            return data.measurments.count
        case 3:
            return data.chosenFixtures.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID,
                                                       for: indexPath) as? ResultTableViewCell else {
                                                        return UITableViewCell()
        }
        cell.configure(section: indexPath.section,
                       indexPath: indexPath.row,
                       sizes: data.sizes,
                       totalUnits: data.totalUnits,
                       measurments: data.measurments,
                       chosenFixtures: data.chosenFixtures)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView,
                   estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 28
    }
    
    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 0,
                                        height: 28))
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let view = TableHeaderView(section: section,
                                   frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: tableView.bounds.width,
                                                 height: 45),
                                   safeLeft: safeLeft,
                                   safeWidth: safeWidth)
        view.button.addTarget(self,
                              action: #selector(showInfo(_:)),
                              for: .touchUpInside)
        return view
    }
    
    
    
}
