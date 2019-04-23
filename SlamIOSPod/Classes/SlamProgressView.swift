//
//  SlamProgressView.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/19/19.
//  Copyright © 2019 Steve Sheets. All rights reserved.
//

import UIKit

// MARK: Class

/// Closure based Progress view
public class SlamProgressView: UIProgressView, SlamViewProtocol {

    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    public var visibleDataSource: Slam.FlagClosure?

    // MARK: Properties
    
    /// Optional data source closure for current page (0.0 to 1.0)
    public var progresDataSource: Slam.DoubleClosure?

    // MARK: Protocol Methods
    
    public func fillUI() {
        if let progresDataSource = progresDataSource {
            var value = Float(progresDataSource())
            if value < 0.0 {
                value = 0.0
            }
            if value > 1.0 {
                value = 1.0
            }
            
            if value != self.progress {
                self.progress = value
            }
        }
    }
}

// MARK: Extension

extension UIViewController {
    
    /// Returns an ProgressView with given referral id
    ///
    /// - Parameter referrral: String with name of ProgressView
    /// - Returns: Returns ProgressView with given name
    func findProgressViewElement(with referrral: String) -> SlamProgressView? {
        return findElement(with: referrral) as? SlamProgressView
    }
    
}
