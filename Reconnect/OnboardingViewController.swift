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
        
        pages.append(pageOne)
        pages.append(pageTwo)
        pages.append(pageThree)
        
        onboardingPageView.setViewControllers([pageOne], direction: .forward, animated: false, completion: nil)
        
        // Set page control
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
    }
    
    @IBAction func showNextPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedSlides" {
            onboardingPageView = segue.destination as? UIPageViewController
        }
    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        print("valuechanged")
    }
    
    @IBAction func tapped(_ sender: Any) {
        print("tapped")
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
//            pageControl.currentPage = currentPage
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if !completed {
            let index = pages.index(of: previousViewControllers[0])
            if let previousPage = index {
//                pageControl.currentPage = previousPage
            }
        }
    }
}
