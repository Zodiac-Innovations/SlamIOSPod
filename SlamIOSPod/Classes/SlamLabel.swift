//
//  SlamLabel.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/15/19.
//  Copyright (c) 2019 Steve Sheets. All rights reserved.
//

import UIKit

// MARK: Class

/// Closure based Label view
///
/// This class provides a closure based Label view. It only supports the SlamViewProtocol (with appropriate properties and functions).
///
/// The textDataSource property contains a closure that provides the name of the button to display.
public class SlamLabel: UILabel, SlamViewProtocol {
    
    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    public var visibleDataSource: Slam.FlagClosure?

    // MARK: Properties
    
    /// Optional data source closure for text of label
    public var textDataSource: Slam.LabelClosure?
    
     // MARK: Protocol Methods
    
    public func fillUI() {
        if let textDataSource = textDataSource {
            let string = textDataSource()
            
            if string != self.text {
                self.text = string
            }
        }
    }
}

// MARK: Extension

public extension UIViewController {
    
    /// Returns an Label with given referral id
    ///
    /// - Parameter referrral: String with name of Label
    /// - Returns: Returns Label with given name
    func findLabelElement(with referrral: String) -> SlamLabel? {
        return findElement(with: referrral) as? SlamLabel
    }
    
}
