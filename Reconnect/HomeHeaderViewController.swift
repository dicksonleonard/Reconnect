//
//  HomeHeaderViewController.swift
//  Reconnect
//
//  Created by Yolanda Halim on 11/02/19.
//  Copyright © 2019 Codebusters. All rights reserved.
//

import UIKit

class HomeHeaderViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        testLabel.text = "qwer ty qwer tyqwer tyq wertyq wertyqwe rtyqwer tyqwert yqwerty qwerty"

        // Do any additional setup after loading the view.
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
