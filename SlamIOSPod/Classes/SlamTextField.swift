//
//  SlamTextField.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/19/19.
//  Copyright © 2019 Zodiac Innovations. All rights reserved.
//

import UIKit

// MARK: Class

/// Closure based Text Field
///
/// This class provides a closure based Stepper view. It supports the SlamViewProtocol, and SlamControlProtocol (with appropriate properties and functions).
public class SlamTextField: UITextField, SlamControlProtocol {
    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    public var visibleDataSource: Slam.FlagClosure?
    
    public var enableDataSource: Slam.FlagClosure?
    
    // MARK: Computed Properties
    
    /// Safe version of text
    public var textValue: String {
        return self.text ?? ""
    }
    
    // MARK: Protocol Methods
    
    public func fillUI() {
    }


}

// MARK: Extension

public extension UIViewController {
    
    /// Returns an TextField with given referral id
    ///
    /// - Parameter referrral: String with name of TextField
    /// - Returns: Returns TextField with given name
    func findTextFieldElement(with referrral: String) -> SlamTextField? {
        return findElement(with: referrral) as? SlamTextField
    }
    
}

