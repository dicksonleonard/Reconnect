//
//  HomeViewController.swift
//  Reconnect
//
//  Created by Yolanda Halim on 08/02/19.
//  Copyright © 2019 Codebusters. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var dailyQuoteButton: UIButton!
    @IBOutlet weak var dailyTipsButton: UIButton!
    @IBOutlet weak var dailyContentCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()        // Do any additional setup after loading the view.
        dailyContentCV.isPagingEnabled = true
        dailyContentCV.delegate = self
        dailyContentCV.dataSource = self
        
//        self.dailyContentCV!.register(DailyQuoteCVCell.self, forCellWithReuseIdentifier: "dailyQuoteCell")
//        self.dailyContentCV!.register(DailyTipsCVCell.self, forCellWithReuseIdentifier: "dailyQuoteCell")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let flowLayout = self.dailyContentCV.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: self.dailyContentCV.bounds.width,
                                        height: self.dailyContentCV.bounds.height)
        }
    }

    @IBAction func changeToDailyQuote(_ sender: Any) {
        dailyQuoteButton.setTitleColor(.black, for: .normal)
        dailyTipsButton.setTitleColor(.gray, for: .normal)
//        dailyContentCV.beginInteractiveMovementForItem(at: IndexPath.init(item: 0, section: 0))
//        dailyContentCV.updateInteractiveMovementTargetPosition(CGPoint(x: 0, y: 0))
//        dailyContentCV.endInteractiveMovement()
    }

    @IBAction func changeToDailyTips(_ sender: Any) {
//        dailyTipsButton.setTitleColor(.black, for: .normal)
//        dailyQuoteButton.setTitleColor(.gray, for: .normal)
//        print("sections:  \(dailyContentCV.numberOfSections)")
//        print("item in section 0:  \(dailyContentCV.numberOfItems(inSection: 0))")
        dailyContentCV.selectItem(at: dailyContentCV.indexPathsForVisibleItems[0],
                                  animated: true, scrollPosition: UICollectionView.ScrollPosition.left)
//       print("item in section 1:  \(dailyContentCV.numberOfItems(inSection: 1))")
//        print("Index path for item:  \(dailyContentCV.indexPathForItem(at: CGPoint(x: 0, y: 0)) as Any)")
//                dailyContentCV.beginInteractiveMovementForItem(at: IndexPath.init(item: 1, section: 0))
//        dailyContentCV.updateInteractiveMovementTargetPosition(CGPoint(x: 0, y: 0))
//        dailyContentCV.endInteractiveMovement()
    }

    // delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
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
