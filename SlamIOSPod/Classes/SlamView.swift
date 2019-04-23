//
//  SlamView.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/16/19.
//  Copyright © 2019 Steve Sheets. All rights reserved.
//

import UIKit

// MARK: Protocol

/// Protocol for all custom UIViews
public protocol SlamViewProtocol : UIView {
    
    // MARK: Required Properties
    
    /// Referral name of item
    var referral: String { get set }
    
    /// Optional data source closure for visisible status of button
    var visibleDataSource: Slam.FlagClosure? { get set }
    
    // MARK: Required Methods
    
    /// View specific code to fill UI when needed
    /// This normally should not be invoked directly, instead use updateUI()
    func fillUI()
}

/// Protocol for larger data sources View
public protocol SlamResetProtocol {
    
    // MARK: Required Methods

    /// View specific code to reset UI when needed
    /// Ex: TableView reloads data
    /// This normally should not be invoked directly, instead use resetUI()
    func reloadUI()
}

/// Protocol for all custom UIControls
public protocol SlamControlProtocol : UIControl, SlamViewProtocol {
    
    // MARK: Required Properties
    
    /// Optional data source closure for enable status of switch
    var enableDataSource: Slam.FlagClosure? { get set }

}

/// Protocol for all custom Interactive UIControls
public protocol SlamInteractiveProtocol : SlamViewProtocol {
    
    // MARK: Required Properties
    
    /// Optional Name of the Task to invoke with button pressed
    var task: String { get set }
    
    /// Optional Parameter of the Task to invoke with button pressed
    var param: String { get set }
    
    /// Optional Flag used signifiy if pressed, root will be updated.
    var autoUI: Bool { get set }
    
    /// Optional Closure to invoke with button pressed
    var pressActionBlock: Slam.ActionClosure?  { get set }
    
}

// MARK: Extension

extension SlamInteractiveProtocol {

    // MARK: Public Method
    
    /// Action method invoked when view is pressed. It invokes the closure.
    func pressAction() {
        if let pressActionBlock = pressActionBlock {
            pressActionBlock()
        }
        
        if !task.isEmpty {
            SlamTask.runTask(name: task, param: param)
        }
        
        if autoUI {
            self.updateRootUI()
        }
    }
}

// MARK: Class

/// Closure based View Controller
open class SlamView: UIView, SlamViewProtocol {

    // MARK: Protocol Properties
        
    @IBInspectable public var referral: String = ""

    public var visibleDataSource: Slam.FlagClosure?

    // MARK: Protocol Properties

    public func fillUI() {
        
    }
    
}

// MARK: Extension

// Extensions to UIView for Closure programming
public extension UIView {

    // MARK: Public Methods
    
    /// Find Root View
    ///
    /// - Returns: UIView that is contained by UIWindow
    func findRootView() -> UIView? {
        var view = self
        while true {
            if let nextView = view.superview {
                if let _ = nextView as? UIWindow {
                    return view
                }
                else {
                    view = nextView
                }
            }
            else {
                return view
            }
        }
    }

    /// Update the User Interface of the view (and sub views)
    func updateUI() {
        if let v = self as? SlamViewProtocol {
            let currentlyVisible = !v.isHidden
            var wantVisible = currentlyVisible
            if let visibleDataSource = v.visibleDataSource {
                wantVisible = visibleDataSource()
            }
            
            if !wantVisible, currentlyVisible {
                self.isHidden = true
            }
            
            if let c = v as? SlamControlProtocol {
                if let enableDataSource = c.enableDataSource {
                    let isActive = enableDataSource()
                    
                    if c.isEnabled != isActive {
                        c.isEnabled = isActive
                    }
                }
            }
            
            v.fillUI()
            
            if wantVisible, !currentlyVisible {
                self.isHidden = false
            }
        }
        
        for v in subviews {
            v.updateUI()
        }
    }
    
    /// Reset the User Interface of the view (and sub views)
    func resetUI() {
        if let v = self as? SlamResetProtocol {
            v.reloadUI()
        }
        
        for v in subviews {
            v.resetUI()
        }
    }

    
    /// Update the User Interface of the root view (and sub views)
    func updateRootUI() {
        if let view = findRootView() {
            view.updateUI()
        }
    }
    
    /// Reset the User Interface of the root view (and sub views)
    func resetRootUI() {
        if let view = findRootView() {
            view.resetUI()
        }
    }
    
   /// Returns an UIView with given referral id (including self)
    ///
    /// - Parameter referrral: String with name of element
    /// - Returns: Returns element with given name
    func findElement(with referrral: String) -> UIView? {
        if let element = self as? SlamViewProtocol {
            if element.referral == referrral {
                return element
            }
        }
        
        for sub in subviews {
            if let element = sub.findElement(with: referrral) {
                return element
            }
        }
        
        return nil
    }
}

