//
//  HomeViewController.swift
//  Reconnect
//
//  Created by Yolanda Halim on 08/02/19.
//  Copyright © 2019 Codebusters. All rights reserved.
//

import UIKit
import Contacts

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var dailyContentTableHeader: UIView!
    private var contactListArr: [Person] = []
    private var randomRemindedContactArr: [Person] = []
    private var showRandomRemindedContactArr: [Person] = []
    private var randomNotRemindedContactArr: [Person] = []
    private var showRandomNotRemindedContactArr: [Person] = []

    private var isFirstRun = true

    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
        
        if isFirstRun {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.fetchContact()
                for contact in appDelegate.contacts {
                    let newContact = Person(name: contact.name, lastName: "", jobTitle: nil, image: contact.image, periode: .notIntroduced, lastContact: nil, nextContact: nil)
                    contactListArr.append(newContact)
                }
            }

            let randomContact = contactListArr.shuffled()
            randomRemindedContactArr = getRandomContact(contactList: randomContact, isReminded: true)
            randomNotRemindedContactArr = getRandomContact(contactList: randomContact, isReminded: false)
            isFirstRun = false
        }
        
        for index in 0..<3 {
            showRandomRemindedContactArr.append(randomRemindedContactArr[index])
            showRandomNotRemindedContactArr.append(randomNotRemindedContactArr[index])
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return showRandomRemindedContactArr.count
        } else if section == 1 {
            return showRandomNotRemindedContactArr.count
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "homeContactCell", for: indexPath) as? HomeContactCell {
            if indexPath.section == 0 {
                let randomContact = self.showRandomRemindedContactArr[indexPath.row]
                cell.nameLabel.text = randomContact.name
                cell.profileImageView.image = randomContact.image
            } else if indexPath.section == 1 {
                let randomContact = self.showRandomRemindedContactArr[indexPath.row]
                cell.nameLabel.text = randomContact.name
                cell.profileImageView.image = randomContact.image            }
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: set for tableView section header

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "People I want to reconnect this week"
        } else if section == 1 {
            return "People I haven’t reconnect with"
        }
        return "Section \(section)"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        let screenRect = UIScreen.main.bounds
        let headerLabel = UILabel(frame: CGRect(x: 16, y: 0, width: screenRect.width, height: 100))
        headerLabel.font = UIFont.boldSystemFont(ofSize: 27)
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.numberOfLines = 0
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    // MARK: Set the tableView section footer
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let numberOfRow = tableView.numberOfRows(inSection: section)
        if numberOfRow < 6 {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
            let showMoreButton = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.width * 0.9, height: footerView.frame.height * 0.6))
            showMoreButton.center = CGPoint(x: footerView.center.x, y: 40)
            showMoreButton.setTitle("Show More", for: UIControl.State.normal)
            showMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            showMoreButton.backgroundColor = #colorLiteral(red: 0, green: 0.7714591622, blue: 0.7574598193, alpha: 1)
            showMoreButton.layer.cornerRadius = 10.0
            showMoreButton.tag = section
            showMoreButton.addTarget(self, action: #selector(showMore), for: .touchUpInside)
            footerView.addSubview(showMoreButton)
            return footerView
        }
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if showRandomRemindedContactArr.count < 6 || showRandomNotRemindedContactArr.count < 6 {
            return 100
        }
        return 0
    }

//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//
//        super.viewWillTransition(to: size, with: coordinator)
//
//        DispatchQueue.main.async {
//            self.homeTableView.tableFooterView?.layoutIfNeeded()
//            self.homeTableView.tableFooterView = self.homeTableView.tableFooterView
//        }
//    }
    
    // MARK: this function to get random reminded contact
    func getRandomContact (contactList: [Person], isReminded: Bool) -> [Person] {
        var randomContact: [Person] = []
        
        for index in 0..<contactList.count {
            let contact = contactList[index]
            if isReminded {
                if contact.periode == .oneMonth {
                    randomContact.append(contact)
                }
            } else {
                if contact.periode == .notIntroduced {
                    randomContact.append(contact)
                }
            }
        }

        // if no reminder at all (this for the initial case)
        if randomContact.isEmpty {
            for index in 0..<6 {
                randomContact.append(contactList[index])
            }
        }
        
        return randomContact
    }

    @objc func showMore(sender: UIButton) {
        let section = sender.tag
        homeTableView.beginUpdates()
        if section == 0 {
            for index in 3..<6 {
                showRandomRemindedContactArr.append(randomRemindedContactArr[index])
                homeTableView.insertRows(at: [IndexPath(row: index, section: section)], with: .fade)
            }
        } else {
            for index in 3..<6 {
                showRandomNotRemindedContactArr.append(randomNotRemindedContactArr[index])
                homeTableView.insertRows(at: [IndexPath(row: index, section: section)], with: .fade)
            }
        }
        homeTableView.endUpdates()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
