//
//  HomeHeaderViewController.swift
//  Reconnect
//
//  Created by Yolanda Halim on 11/02/19.
//  Copyright © 2019 Codebusters. All rights reserved.
//

import UIKit

class HomeHeaderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var dailyContentCV: UICollectionView!
    @IBOutlet weak var quoteButton: UIButton!
    @IBOutlet weak var tipsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyContentCV.isPagingEnabled = true
        dailyContentCV.delegate = self
        dailyContentCV.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeToQuote(_ sender: Any) {
//        var scrollDirection = UICollectionView.ScrollPosition.right
//        if dailyContentCV.indexPathsForVisibleItems[0].row == 0 {
//            scrollDirection = UICollectionView.ScrollPosition.left
//        }
//        dailyContentCV.scrollToItem(at: IndexPath(item: 0, section: 0), at: scrollDirection, animated: true)
          dailyContentCV.scrollRectToVisible(CGRect(x: 0, y: 0, width: 10, height: 10), animated: true)
        
//        UIView.animate(withDuration: 3) {
//            self.dailyContentCV.contentOffset = CGPoint(x: 0.0, y: 0.0)
//        }
    }
    
    @IBAction func changeToTips(_ sender: Any) {
        var scrollDirection = UICollectionView.ScrollPosition.right
        if dailyContentCV.indexPathsForVisibleItems[0].row == 1 {
            scrollDirection = UICollectionView.ScrollPosition.left
        }
        dailyContentCV.scrollToItem(at: IndexPath(item: 1, section: 0), at: scrollDirection, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    // to initiate the view of the selected cell when the collection view is 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            if let dailyQuoteCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyQuoteCell", for: indexPath) as? DailyQuoteCVCell {
                quoteButton.setTitleColor(.black, for: UIControl.State.normal)
                tipsButton.setTitleColor(.gray, for: UIControl.State.normal)
                return dailyQuoteCVCell
            }
        } else if indexPath.row == 1 {
            if let dailyTipsCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyTipsCell", for: indexPath) as? DailyTipsCVCell {
                quoteButton.setTitleColor(.gray, for: UIControl.State.normal)
                tipsButton.setTitleColor(.black, for: UIControl.State.normal)
                return dailyTipsCVCell
            }
        }
        return UICollectionViewCell()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // to know which cell is section the section belong
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0, scrollView.contentOffset.x <= 173 {
            quoteButton.setTitleColor(.black, for: UIControl.State.normal)
            tipsButton.setTitleColor(.gray, for: UIControl.State.normal)
        } else {
            quoteButton.setTitleColor(.gray, for: UIControl.State.normal)
            tipsButton.setTitleColor(.black, for: UIControl.State.normal)
        }
    }
    
    

}
