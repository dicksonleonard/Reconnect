//
//  FadeSegue.swift
//  Reconnect
//
//  Created by Dickson Leonard on 13/02/19.
//  Copyright © 2019 Codebusters. All rights reserved.
//

import UIKit

class FadeSegue: UIStoryboardSegue {
    override func perform() {
        // Get the view of the source
        let sourceViewControllerView = self.source.view
        // Get the view of the destination
        let destinationViewControllerView = self.destination.view
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        if let destinationView = destinationViewControllerView, let sourceView = sourceViewControllerView {
            // Make the destination view the size of the screen
            destinationView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            
            // Insert destination below the source
            // Without this line the animation works but the transition is not smooth as it jumps from white to the new view controller
            destinationView.alpha = 0
            sourceView.addSubview(destinationView)
            // Animate the fade, remove the destination view on completion and present the full view controller
            UIView.animate(withDuration: 1, animations: {
                destinationView.alpha = 1
            }, completion: { (_) in
                destinationView.removeFromSuperview()
                self.source.present(self.destination, animated: false, completion: nil)
            })
        }
    }
}
