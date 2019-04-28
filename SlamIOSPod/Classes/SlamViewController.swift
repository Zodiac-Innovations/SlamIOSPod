//
//  SlamViewController.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/16/19.
//  Copyright © 2019 Steve Sheets. All rights reserved.
//

import UIKit

// MARK: Extension

// Extensions to UIViewController for Closure programming

public extension UIViewController {
    
    // MARK: Class Methods
    
    /// Find the top most view controller
    ///
    /// - Returns: UIViewController that is topmost.
    static func topViewController() -> UIViewController? {
        guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
            return nil
        }
        
        var topController = rootViewController
        
        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }
        
        return topController
    }
    
    /// Dismiss modally the top most view controller
    ///
    /// - Parameter animated: Boolean flag to indicate animating or not animating the pop. The default is true.
    static func popTopViewController(animated: Bool = true) {
        if let top = topViewController() {
            top.dismiss(animated: animated, completion: nil)
        }
    }
    
    /// Push modally the given view controller the top most view controller
    ///
    /// - Parameter storyboardID: String containing storyboard ID of view controller to load and push.
    /// - Parameter animated: Boolean flag to indicate animating or not animating the push. The default is true.
    static func push(storyboardID: String, animated: Bool = true) {
        if let top = topViewController() {
            let vc = Slam.mainStoryboad.instantiateViewController(withIdentifier: storyboardID)
            
            top.present(vc, animated: animated, completion: nil)
        }
    }
    
    // MARK: Public Methods

    /// Update the User Interface of the main view (and sub views)
    func updateMainUI() {
        self.view.updateUI()
    }
    
    /// Reset the User Interface of the main view (and sub views)
    func resetMainUI() {
        self.view.resetUI()
    }
    
    /// Returns an View with given referral id
    ///
    /// - Parameter referrral: String with name of View
    /// - Returns: Returns View with given name
    func findElement(with referrral: String) -> UIView? {
        return view.findElement(with: referrral)
    }

}

