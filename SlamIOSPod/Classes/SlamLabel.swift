//
//  SlamLabel.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/15/19.
//  Copyright (c) 2019 Steve Sheets. All rights reserved.
//

import UIKit

/// Closure based Label view
public class SlamLabel: UILabel {
    
    // MARK: Typealias
    
    /// Closure type that is passed nothing, and returns string.
    public typealias LabelClosure = () -> String
    
    /// Closure type that is passed nothing, and returns Boolean flag.
    public typealias FlagClosure = () -> Bool
    
    // MARK: Properties
    
    @IBInspectable public var referral: String = ""
    
    public var textDataSource: SlamLabel.LabelClosure?
    
    public var visibleClosure: SlamLabel.FlagClosure?
    
    // MARK: Methods
    
    public func updateUI() {
        // Hide the view if needed, set text if needed, then show if needed.
        
        let currentlyVisible = !self.isHidden
        var wantVisible = currentlyVisible
        if let visibleClosure = visibleClosure {
            wantVisible = visibleClosure()
        }
        
        if !wantVisible, currentlyVisible {
            self.isHidden = true
        }
        
        if let textDataSource = textDataSource {
            let string = textDataSource()
            
            if string != self.text {
                self.text = string
            }
        }
        
        if wantVisible, !currentlyVisible {
            self.isHidden = false
        }
    }
}
