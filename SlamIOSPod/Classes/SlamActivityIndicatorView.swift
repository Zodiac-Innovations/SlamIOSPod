//
//  SlamActivityIndicatorView.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/19/19.
//  Copyright © 2019 Steve Sheets. All rights reserved.
//

import UIKit

// MARK: Class

/// Closure based Activity Indicator
public class SlamActivityIndicatorView: UIActivityIndicatorView, SlamViewProtocol {

    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    public var visibleDataSource: Slam.FlagClosure?
    
    // MARK: Properties
    
    /// Optional data source closure for active
    var animatingDataSource: Slam.FlagClosure? = nil

    // MARK: Protocol Methods
    
    public func fillUI() {
        if let animatingDataSource = animatingDataSource {
            let flag = animatingDataSource()
            
            if isAnimating {
                if !flag {
                    stopAnimating()
                }
            }
            else {
                if flag {
                    startAnimating()
                }
            }
        }
    }
}

// MARK: Extension

extension UIViewController {
    
    /// Returns an ActivityIndicatorView with given referral id
    ///
    /// - Parameter referrral: String with name of ActivityIndicatorView
    /// - Returns: Returns ActivityIndicatorView with given name
    func findActivityIndicatorViewElement(with referrral: String) -> SlamActivityIndicatorView? {
        return findElement(with: referrral) as? SlamActivityIndicatorView
    }
    
}
