//
//  ContactTableViewController.swift
//  Contact Reconnect
//
//  Created by ari kurniawan on 06/02/19.
//  Copyright © 2019 ari kurniawan. All rights reserved.
//

import UIKit
import Contacts

class ContactTableViewController: UITableViewController {

    var contactsArray: [Person] = []
    var filteredContact: [Person] = []
    let searchController = UISearchController(searchResultsController: nil)

    lazy var contacts: [CNContact] = {
        let contactStore = CNContactStore()
        let keysToFetch: [Any] = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataAvailableKey,
            CNContactThumbnailImageDataKey]

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
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
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
            contactsArray.append(Person(name: "\(contact.givenName) \(contact.familyName)"))
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredContact.count
        } else {
            return contactsArray.count
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Not Introduced"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Buat cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactCell

        let personAtRow: Person
        if isFiltering() {
            personAtRow = filteredContact[indexPath.row]
        } else {
            personAtRow = contactsArray[indexPath.row]
        }

        cell.nameLabel.text = personAtRow.name

        // Get initial
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ContactTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
