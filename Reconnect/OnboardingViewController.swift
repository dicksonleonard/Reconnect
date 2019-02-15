//
//  OnboardingViewController.swift
//  Reconnect
//
//  Created by Dickson Leonard on 13/02/19.
//  Copyright © 2019 Codebusters. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    var onboardingPageView: UIPageViewController!
    var pages = [UIViewController]()
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var contactButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Load onboarding pages to page view controller
        onboardingPageView.delegate = self
        onboardingPageView.dataSource = self
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let pageOne = storyboard.instantiateViewController(withIdentifier: "ob1")
        let pageTwo = storyboard.instantiateViewController(withIdentifier: "ob2")
        let pageThree = storyboard.instantiateViewController(withIdentifier: "ob3")
        let pageFour = storyboard.instantiateViewController(withIdentifier: "ob4")
        let pageFive = storyboard.instantiateViewController(withIdentifier: "ob5")
        
        pages.append(pageOne)
        pages.append(pageTwo)
        pages.append(pageThree)
        pages.append(pageFour)
        pages.append(pageFive)
        
        onboardingPageView.setViewControllers([pageOne], direction: .forward, animated: false, completion: nil)
        
        // Set page control
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
    }
    
    @IBAction func showNextPage(_ sender: UIButton) {
        pageControl.currentPage += 1
        
        if pageControl.currentPage < 4 {
            // Page 1-4 : Show next page
            let nextViewController = pages[pageControl.currentPage+1]
            onboardingPageView.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        } else {
            // Page 5 : Show add contact options
            UIView.animate(withDuration: 1.0) {
                self.nextButton.isHidden = true
                self.contactButtonView.isHidden = false
            }
        }
    }
    
    @IBAction func getDeviceContact(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        if let delegate = appDelegate {
            delegate.fetchContact()
        }
        
        goToHome(self)
    }
    
    @IBAction func goToHome(_ sender: Any) {
        performSegue(withIdentifier: "ShowMain", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedSlides" {
            onboardingPageView = segue.destination as? UIPageViewController
        }
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

extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let cur = pages.index(of: viewController)!
        
        if cur == 0 {
            return nil
        } else {
            let prev = abs((cur - 1) % pages.count)
            return pages[prev]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let cur = pages.index(of: viewController)!
        
        if cur == (pages.count - 1) {
            return nil
        } else {
            let nxt = abs((cur + 1) % pages.count)
            return pages[nxt]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let index = pages.index(of: pendingViewControllers[0])
        if let currentPage = index {
            pageControl.currentPage = currentPage
            
            if currentPage == 4 {
                if self.contactButtonView.isHidden {
                    UIView.animate(withDuration: 1.0) {
                        self.nextButton.isHidden = true
                        self.contactButtonView.isHidden = false
                    }
                }
            }
            else {
                if !self.contactButtonView.isHidden {
                    UIView.animate(withDuration: 1.0) {
                        self.nextButton.isHidden = false
                        self.contactButtonView.isHidden = true
                    }
                }
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if !completed {
            let index = pages.index(of: previousViewControllers[0])
            if let previousPage = index {
                pageControl.currentPage = previousPage
                
                if previousPage == 4 {
                    if self.contactButtonView.isHidden {
                        UIView.animate(withDuration: 1.0) {
                            self.nextButton.isHidden = true
                            self.contactButtonView.isHidden = false
                        }
                    }
                }
                else {
                    if !self.contactButtonView.isHidden {
                        UIView.animate(withDuration: 1.0) {
                            self.nextButton.isHidden = false
                            self.contactButtonView.isHidden = true
                        }
                    }
                }
            }
        }
    }
}
