//
//  HomeViewController.swift
//  Reconnect
//
//  Created by Yolanda Halim on 08/02/19.
//  Copyright © 2019 Codebusters. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var dailyContentTableHeader: UIView!
    private let needToAddTagContacts : [Person] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyContentTableHeader.frame(forAlignmentRect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: homeTableView.visibleSize.width, height: homeTableView.visibleSize.height * 0.4)))
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {  return UITableViewCell()    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
