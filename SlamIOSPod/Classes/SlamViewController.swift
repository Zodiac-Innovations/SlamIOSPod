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
    
    // MARK: Public Properties

    /// Update the User Interface of the main view (and sub views)
    func updateUI() {
        self.view.updateUI()
    }
    
    /// Reset the User Interface of the main view (and sub views)
    func resetUI() {
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

