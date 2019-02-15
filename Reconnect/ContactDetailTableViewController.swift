//
//  ContactDetailTableViewController.swift
//  Reconnect
//
//  Created by Yolanda Halim on 13/02/19.
//  Copyright © 2019 Codebusters. All rights reserved.
//

import UIKit

class ContactDetailTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Periode.allCases.count - 2
    }
    
    func pickerView(_ pickerview: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return Periode.allCases[row].rawValue
    }
    
    var selectedContact: Person?
    var remindMePickerData: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // MARK: Filling contents for Contact Details.
        if let contact = selectedContact {
            self.title = "Details"
            photoUIImageView.image = contact.image
            nameLabelOutlet.text = contact.name
            mobileLabelOutlet.text = contact.mobileNumber
            emailLabelOutlet.text = contact.email
            messageLabelOutlet.text = contact.mobileNumber
            contactNotes()
            //notesLabelOutlet.text = contact.personalNotes
            
            // MARK: Change the button if no data is present
            if contact.email == "-" {
                emailIconOutlet.setImage(#imageLiteral(resourceName: "eMailDeactivatedIcon"), for: .normal)
                emailIconOutlet.isEnabled = false
            } else {
                emailIconOutlet.setImage(#imageLiteral(resourceName: "eMailIcon"), for: .normal)
                emailIconOutlet.isEnabled = true }
            
            if contact.mobileNumber == "-" {
                callIconOutlet.setImage(#imageLiteral(resourceName: "telephoneDeactivatedIcon"), for: .normal)
                callIconOutlet.isEnabled = false
            } else {
                callIconOutlet.setImage(#imageLiteral(resourceName: "telephoneIcon"), for: .normal)
                callIconOutlet.isEnabled = true }
            
            if contact.mobileNumber == "-" {
                messageIconOutlet.setImage(#imageLiteral(resourceName: "messageDeactivatedIcon"), for: .normal)
                messageIconOutlet.isEnabled = false
            } else {
                messageIconOutlet.setImage(#imageLiteral(resourceName: "messageIcon"), for: .normal)
                messageIconOutlet.isEnabled = true }
            
            remindPickerView.delegate = self
            remindPickerView.dataSource = self
            
        }
        


    }
    
    // MARK: - IB Stuffs
    @IBOutlet weak var photoUIImageView: UIImageView!
    @IBOutlet weak var nameLabelOutlet: UILabel!
    @IBOutlet weak var mobileLabelOutlet: UILabel!
    @IBOutlet weak var messageLabelOutlet: UILabel!
    @IBOutlet weak var emailLabelOutlet: UILabel!
    @IBOutlet weak var notesLabelOutlet: UITextView!
    
    @IBOutlet weak var callIconOutlet: UIButton!
    @IBOutlet weak var emailIconOutlet: UIButton!
    @IBOutlet weak var messageIconOutlet: UIButton!
    
    @IBOutlet weak var remindPickerView: UIPickerView!
    
    // MARK: Top buttons
    
    @IBAction func callMobileButton(_ sender: UIButton) {
        makeAPhoneCall()
    }
    @IBAction func emailButton(_ sender: UIButton) {
    }
    @IBAction func messageButton(_ sender: UIButton) {
    }

    // MARK: - Functions
    
    func makeAPhoneCall() {
        
    }
    
    func contactNotes() {
        let contact = selectedContact
        if notesLabelOutlet.text == "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat." {
            notesLabelOutlet.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            notesLabelOutlet.text = "Type any information that remind you of this person. Profession, skills, shared history, interest, etc here..."
        } else {
            notesLabelOutlet.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            notesLabelOutlet.text = contact?.personalNotes
        }
    }
    /*
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
     */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
