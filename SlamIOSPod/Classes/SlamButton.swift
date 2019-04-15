//
//  SlamButton.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/15/19.
//  Copyright (c) 2019 Steve Sheets. All rights reserved.
//

import UIKit

/// Closure based Button view
public class SlamButton: UIButton {
    
    // MARK: Typealias
    
    /// Simpliest of Closure, used for a simple action
    public typealias ActionClosure = () -> Void
    
    /// Closure type that is passed nothing, and returns string.
    public typealias LabelClosure = () -> String
    
    /// Closure type that is passed nothing, and returns Boolean flag.
    public typealias FlagClosure = () -> Bool
    
    // MARK: Properties
    
    @IBInspectable public var referral: String = ""
    
    @IBInspectable public var autoUpdateLevel: Int = 0
    
    public var pressAction: SlamButton.ActionClosure?
    
    public var textDataSource: SlamButton.LabelClosure?
    
    public var enableDataSource: SlamButton.FlagClosure?
    
    public var visibleClosure: SlamButton.FlagClosure?
    
    
    // MARK: Lifecycle Methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(press(sender:)), for: .touchUpInside)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addTarget(self, action: #selector(press(sender:)), for: .touchUpInside)
    }
    
    // MARK: Methods
    
    /// Action method invoked when view is pressed. It invokes the closure.
    @objc func press(sender: UIView) {
        if let pressAction = pressAction {
            pressAction()
        }
    }
    
    func updateUI() {
        // Hide the view if needed, set text if neeed, enable/disable if needed, then show if needed.
        
        let currentlyVisible = !isHidden
        var wantVisible = currentlyVisible
        if let visibleClosure = visibleClosure {
            wantVisible = visibleClosure()
        }
        
        if !wantVisible, currentlyVisible {
            isHidden = true
        }
        
        if let textDataSource = textDataSource {
            let string = textDataSource()
            
            if string != title(for: .normal) {
                setTitle(string, for: .normal)
            }
        }
        
        if let enableDataSource = enableDataSource {
            let isActive = enableDataSource()
            
            if isEnabled != isActive {
                isEnabled = isActive
            }
        }
        
        if wantVisible, !currentlyVisible {
            isHidden = false
        }
    }
}
