//
//  ShowMoreViewController.swift
//  Reconnect
//
//  Created by Yolanda Halim on 16/02/19.
//  Copyright © 2019 Codebusters. All rights reserved.
//

import UIKit

class ShowMoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var contactArr: [Person] = []
    @IBOutlet weak var showMoreTableView: UITableView!
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = false
        super.viewDidLoad()
        self.title = "More Contacts"
        showMoreTableView.delegate = self
        showMoreTableView.dataSource = self
        showMoreTableView.separatorStyle = UITableViewCell.SeparatorStyle.none    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showMoreContactDetail" {
            if let destination = segue.destination as? ContactDetailTableViewController {
                let indexPath = showMoreTableView.indexPathForSelectedRow!
                if indexPath.section == 0 {
                    destination.selectedContact = contactArr[indexPath.row]
                } else if indexPath.section == 1 {
                    destination.selectedContact = contactArr[indexPath.row]
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = showMoreTableView.dequeueReusableCell(withIdentifier: "homeContactCell") as? HomeContactCell {
            cell.nameLabel.text = contactArr[indexPath.row].name
            cell.profileImageView.image = contactArr[indexPath.row].image
            return cell
        }
        return UITableViewCell()
    }
}
