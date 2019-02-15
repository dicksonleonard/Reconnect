//
//  ContactTableViewController.swift
//  Contact Reconnect
//
//  Created by ari kurniawan on 06/02/19.
//  Copyright © 2019 ari kurniawan. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactTableViewController: UITableViewController {

    var contactsArray: [Person] = []
    var filteredContact: [Person] = []
    let searchController = UISearchController(searchResultsController: nil)
    var isExpanded: [Bool] = [true, true, true, true, true, true, true]
    
    var oneWeekSection:[Person] = []
    var oneMonthSection:[Person] = []
    
    
    lazy var contacts: [CNContact] = {
        let contactStore = CNContactStore()
        let keysToFetch: [Any] = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataAvailableKey,
            CNContactThumbnailImageDataKey,
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactNoteKey]

        // Get all the containers
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }

        var results: [CNContact] = []

        // Iterate all containers and append their contacts to our results array
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)

            do {
                if let keys = keysToFetch as? [CNKeyDescriptor] {
                    let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keys)
                    results.append(contentsOf: containerResults)
                }
                
            } catch {
                print("Error fetching results for container")
            }
        }

        return results
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contact"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Contact"
        navigationItem.searchController = searchController
        definesPresentationContext = true

        // Transfer device contacts to app contacts
        for contact in contacts {
            
            var person = Person(name: "")
            person.name = "\(contact.givenName) \(contact.familyName)"
            //person.lastName = contact.familyName
            person.mobileNumber = contact.phoneNumbers.first?.value.stringValue ?? "-"
            person.email = contact.emailAddresses.first?.value as String? ?? "-"
            person.personalNotes = contact.note
            person.periode = Periode.allCases.randomElement() ?? Periode.notIntroduced
            contactsArray.append(person)
            print(person.periode)
            //contactsArray.append(Person(name: "\(contact.givenName) \(contact.familyName)", mobileNumber: "\(phoneNumber)", email: "\(emailAddress)", personalNotes: contact.note))
            

            oneWeekSection.append(person)
            }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Periode.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isExpanded[section] {
            if isFiltering() {
                return filteredContact.count
            } else {
                return contactsArray.count
            } } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Buat cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactCell {

        let personAtRow: Person
        if isFiltering() {
            personAtRow = filteredContact[indexPath.row]
        } else {
            personAtRow = contactsArray[indexPath.row]
        }
        
        cell.nameLabel.text = personAtRow.name
        
        // Get initial
        return cell
        } else {
            // Cell not found, return regular UITableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseableIdentifier", for: indexPath)
            return cell
        }
    }
    
    // MARK: - Header thingy
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerButton = UIButton(type: .custom)
        headerButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
        
        headerButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        headerButton.tag = section
        switch section {
        case 0:
            headerButton.setTitle(Periode.nextWeek.rawValue, for: .normal)
        case 1:
            headerButton.setTitle(Periode.oneMonth.rawValue, for: .normal)
        case 2:
            headerButton.setTitle(Periode.threeMonth.rawValue, for: .normal)
        case 3:
            headerButton.setTitle(Periode.sixMonth.rawValue, for: .normal)
        case 4:
            headerButton.setTitle(Periode.oneYear.rawValue, for: .normal)
        case 5:
            headerButton.setTitle(Periode.skipped.rawValue, for: .normal)
        default:
            headerButton.setTitle(Periode.notIntroduced.rawValue, for: .normal)
        }
        if isExpanded[section] == true {
            headerButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            headerButton.backgroundColor = #colorLiteral(red: 0, green: 0.8351076245, blue: 0.7949748039, alpha: 1)
        }
        headerButton.contentHorizontalAlignment = .left
        headerButton.titleEdgeInsets = UIEdgeInsets (top: 0, left: 10, bottom: 0, right: 0)
        //headerButton.backgroundColor = .red
        return headerButton
    }
    
    @objc func handleExpandClose(headerButton: UIButton) {
        let section = headerButton.tag
        isExpanded[section] = !isExpanded[section]
        tableView.reloadSections(IndexSet(section...section), with: .automatic)
        print(isExpanded)
//        var indexPaths = [IndexPath]()
//        for row in contacts.indices {
//            let indexPath = IndexPath(row: row, section: section)
//            print(0,row)
//            indexPaths.append(indexPath)
//        }
//        contacts.removeAll()
//        tableView.deleteRows(at: indexPaths, with: .fade)
    }
    // MARK: - Private instance methods

    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredContact = contactsArray.filter({(person: Person) -> Bool in
            return person.name.lowercased().contains(searchText.lowercased())
        })

        tableView.reloadData()
    }

    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToContactDetails" {
            if let destination = segue.destination as? ContactDetailTableViewController,
                let row = tableView.indexPathForSelectedRow?.row {
                    destination.selectedContact = contactsArray[row]
            }
        } else if segue.identifier == "addContact" {
            // Add contact page
            if let destination = segue.destination as? UINavigationController {
                if let targetController = destination.topViewController as? AddContactTableViewController {
                    targetController.delegate = self
                }
            }
        }
    }

}

extension ContactTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension ContactTableViewController: AddContactTableViewControllerDelegate {
    func adddedContact(_ contact: Person) {
        
        // Create new phone contact to be added to device
        let newContact = CNMutableContact()
        
        newContact.givenName = contact.name
        newContact.familyName = contact.lastName

        if let notes = contact.personalNotes {
            newContact.note = notes
        }
        
        if let email = contact.email {
            let homeEmail = CNLabeledValue(label: CNLabelHome, value: email as NSString)
            newContact.emailAddresses = [homeEmail]
        }
        
        if let mobile = contact.mobileNumber {
            let workNumber = CNLabeledValue(label: CNLabelPhoneNumberMain, value: CNPhoneNumber(stringValue: mobile))
            newContact.phoneNumbers = [workNumber]
        }
        
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(newContact, toContainerWithIdentifier: nil)
        do {
            try store.execute(saveRequest)
        } catch {
            print("Add contact failed")
        }
    }
}
