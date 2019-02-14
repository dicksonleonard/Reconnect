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
    private var needToAddTagContactsArray: [Person] = []
    private var needToReminderContactsArray: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        // MARK: need to create connection between Person and CNContact
        let contacts = ContactTableViewController().contacts
        for contact in contacts {
            needToAddTagContactsArray.append(Person(name: "\(contact.givenName) \(contact.familyName)"))
            needToReminderContactsArray.append(Person(name: "\(contact.givenName) \(contact.familyName)"))
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return needToAddTagContactsArray.count
        } else if section == 1 {
            return needToReminderContactsArray.count
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
                cell.nameLabel.text = needToAddTagContactsArray[indexPath.row].name
                cell.profileImageView.image = UIImage(named: "Perik")
            } else if indexPath.section == 1 {
                cell.nameLabel.text = needToReminderContactsArray[indexPath.row].name
                cell.profileImageView.image = UIImage(named: "Perik")
            }
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
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        let showMoreButton = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.width * 0.9, height: footerView.frame.height * 0.6))
        showMoreButton.center = CGPoint(x: footerView.center.x, y: 40)
        showMoreButton.setTitle("Show More", for: UIControl.State.normal)
        showMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        showMoreButton.backgroundColor = UIColor(red: 0, green: 206, blue: 191, alpha: 1.0)
        showMoreButton.layer.cornerRadius = 10.0
        footerView.addSubview(showMoreButton)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
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
