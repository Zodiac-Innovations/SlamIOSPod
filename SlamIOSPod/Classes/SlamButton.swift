//
//  SlamButton.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/15/19.
//  Copyright (c) 2019 Steve Sheets. All rights reserved.
//

import UIKit

// MARK: Class

/// Closure based Button view
///
/// This class provides a closure based Button view. It supports the SlamViewProtocol, SlamControlProtocol, and SlamInteractiveProtocol (with appropriate properties and functions).
///
/// The textDataSource property contains a closure that provides the name of the button to display.
public class SlamButton: UIButton, SlamControlProtocol, SlamInteractiveProtocol {
    
    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    @IBInspectable public var task: String = ""
    
    @IBInspectable public var param: String = ""
    
    @IBInspectable public var autoUI: Bool = false
    
    public var visibleDataSource: Slam.FlagClosure?
    
    public var enableDataSource: Slam.FlagClosure?
    
    public var pressActionBlock: Slam.ActionClosure?

    // MARK: Properties
    
    /// Optional data source closure for text of button
    public var textDataSource: Slam.LabelClosure?
    
    // MARK: Lifecycle Methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(press(sender:)), for: .touchUpInside)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addTarget(self, action: #selector(press(sender:)), for: .touchUpInside)
    }
    
    // MARK: Protocol Methods
    
    public func fillUI() {
        if let textDataSource = textDataSource {
            let string = textDataSource()
            
            if string != title(for: .normal) {
                setTitle(string, for: .normal)
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
    
    /// Returns an Button with given referral id
    ///
    /// - Parameter referrral: String with name of Button
    /// - Returns: Returns Button with given name
    func findButtonElement(with referrral: String) -> SlamButton? {
        return findElement(with: referrral) as? SlamButton
    }

}
