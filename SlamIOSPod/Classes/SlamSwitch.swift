//
//  SlamSwitch.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/18/19.
//  Copyright © 2019 Steve Sheets. All rights reserved.
//

import UIKit

// MARK: Class

/// Closure based Switch view
///
/// This class provides a closure based Switch view. It supports the SlamViewProtocol, SlamControlProtocol, and SlamInteractiveProtocol (with appropriate properties and functions).
///
/// The single closure switchDataSource returns Boolean to indicate the state of the Switch, on or off.
public class SlamSwitch: UISwitch, SlamControlProtocol, SlamInteractiveProtocol {

    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    @IBInspectable public var task: String = ""

    @IBInspectable public var param: String = ""

    @IBInspectable public var autoUI: Bool = false

    public var pressActionBlock: Slam.ActionClosure?

    public var enableDataSource: Slam.FlagClosure?

    public var visibleDataSource: Slam.FlagClosure?
    
    // MARK: Properties
    
    /// Optional data source closure for status of switch
    public var switchDataSource: Slam.FlagClosure?
    
    // MARK: Lifecycle Methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(press(sender:)), for: .touchUpInside)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addTarget(self, action: #selector(press(sender:)), for: .touchUpInside)
    }

    // MARK: Inherited Methods
    
    public func fillUI() {
        if let switchDataSource = switchDataSource {
            let flag = switchDataSource()
            
            if flag != self.isOn {
                setOn(flag, animated: false)
            }
        }
    }
    
    // MARK: Private Methods
    
    /// Action method invoked when view is pressed. It invokes the closure.
    @objc public func press(sender: UIView) {
        pressAction()
    }
}

// MARK: Extension

public extension UIViewController {

    /// Returns an Switch with given referral id
    ///
    /// - Parameter referrral: String with name of Switch
    /// - Returns: Returns Switch with given name
    func findSwitchElement(with referrral: String) -> SlamSwitch? {
        return findElement(with: referrral) as? SlamSwitch
    }
    
}
