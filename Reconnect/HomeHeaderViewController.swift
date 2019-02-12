//
//  HomeHeaderViewController.swift
//  Reconnect
//
//  Created by Yolanda Halim on 11/02/19.
//  Copyright © 2019 Codebusters. All rights reserved.
//

import UIKit

class HomeHeaderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var dailyContentCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dailyContentCV.isPagingEnabled = true
        dailyContentCV.delegate = self
        dailyContentCV.dataSource = self
        
        testLabel.text = "qwer ty qwer tyqwer tyq wertyq wertyqwe rtyqwer tyqwert yqwerty qwerty"

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let flowLayout = self.dailyContentCV.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width:
                self.dailyContentCV.bounds.width,
                                         height: self.dailyContentCV.bounds.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath)
        if indexPath.section == 0 {
            if let dailyQuoteCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyQuoteCell", for: indexPath) as? DailyQuoteCVCell {
                dailyQuoteCVCell.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                return dailyQuoteCVCell
            }
        }
        
        let dailyTipsCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyTipsCell", for: indexPath) as? DailyTipsCVCell
        dailyTipsCVCell?.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        return dailyTipsCVCell ?? UICollectionViewCell()
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
