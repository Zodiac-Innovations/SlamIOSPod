//
//  SlamDatePicker.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 5/15/19.
//

import UIKit

/// Closure based Date Picker view
///
/// This class provides a closure based Date Picker view. It supports the SlamViewProtocol and SlamControlProtocol (with appropriate properties and functions).
public class SlamDatePicker: UIDatePicker, SlamControlProtocol {

    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    public var visibleDataSource: Slam.FlagClosure?
    
    public var enableDataSource: Slam.FlagClosure?

    // MARK: Inherited Methods
    
    public func fillUI() {
    }
    
    // MARK: Lifecycle Methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: Extension

public extension UIViewController {
    
    /// Returns a DatePicker with given referral id
    ///
    /// - Parameter referrral: String with name of DatePickers
    /// - Returns: Returns PickerView with given name
    func findPickerViewElement(with referrral: String) -> SlamDatePicker? {
        return findElement(with: referrral) as? SlamDatePicker
    }
    
}
