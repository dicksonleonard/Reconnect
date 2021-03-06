//
//  AddContactTableViewController.swift
//  Reconnect
//
//  Created by Dickson Leonard on 14/02/19.
//  Copyright © 2019 Codebusters. All rights reserved.
//

import UIKit

class AddContactTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var periodPickerView: UIPickerView!
    
    weak var delegate: AddContactTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set datasource / delegates
        periodPickerView.dataSource = self
        periodPickerView.delegate = self
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        mobileField.delegate = self
        emailField.delegate = self
        
        // Tap tableview to dismiss keyboard
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tableView.addGestureRecognizer(gestureRecognizer)
    }

    @IBAction func dismissPage(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addContact(_ sender: UIBarButtonItem) {
        var newContact = Person(name: firstNameField.text ?? "")
        newContact.lastName = lastNameField.text ?? ""
        newContact.email = emailField.text
        newContact.mobileNumber = mobileField.text
        newContact.personalNotes = notesTextView.text
        
        let pickerViewIndex = periodPickerView.selectedRow(inComponent: 0)
        
        if pickerViewIndex > 0 {
            newContact.periode = Periode.allCases[pickerViewIndex-1]
        }
        
        delegate?.adddedContact(newContact)
        
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == firstNameField {
            // To change the focus we manipulate the firstResponder
            lastNameField.becomeFirstResponder()
        } else if textField == lastNameField {
            mobileField.becomeFirstResponder()
        } else if textField == mobileField {
            emailField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    // Function related to screen touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // If we want to hide the keyboard, we can put the focus outside the textfields
        // Putting the FirstResponder in the ViewController hides the keyboard
        self.becomeFirstResponder()
    }
    
    // By default the ViewController cannot receive focus. We are changing that
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
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

// MARK: UIPickerView datasource / delegate
extension AddContactTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Periode.allCases.count-1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return ""
        } else {
            return Periode.allCases[row-1].rawValue
        }
    }
}

protocol AddContactTableViewControllerDelegate: class {
    func adddedContact(_ contact: Person)
}
