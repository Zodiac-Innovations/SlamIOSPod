//
//  SlamTextView.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/21/19.
//  Copyright © 2019 Zodiac Innovations. All rights reserved.
//

import UIKit

/// Closure based Text View
///
/// This class provides a closure based Switch view. It supports SlamViewProtocol and SlamResetProtocol (with appropriate properties and functions).  Note that as a View that supports SlamResetProtocol, a reloadUI() method must be invoked to update the data (text) stored in the view.
///
/// This class has two optional closure properties. The property textDataSource calculates the current text to display in the text view.  The property textFileDataSource returns a file name, that will be loaded into the text view (if it exists).  One or the other or neither of these options can be used, but not both at once.
public class SlamTextView: UITextView, SlamViewProtocol, SlamResetProtocol {

    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    public var visibleDataSource: Slam.FlagClosure?
    
    public var enableDataSource: Slam.FlagClosure?
    
    // MARK: Properties
    
    /// Optional data source closure for text of view
    public var textDataSource: Slam.LabelClosure?
    
    /// Optional file name data source closure for text of view
    public var textFileDataSource: Slam.LabelClosure?
    
    // MARK: Protocol Methods
    
    public func fillUI() {
    }
    
    public func reloadUI() {
        if let textDataSource = textDataSource {
            let string = textDataSource()
            
            if string != self.text {
                self.text = string
            }
        }
        
        if let textFileDataSource = textFileDataSource {
            let name = textFileDataSource()
            
            loadTextFile(name: name)
        }
    }
    
    // MARK: Public Method
    
    /// Load text file with given name into the view. File must have txt suffix
    ///
    /// - Parameter name: String with name file (missing txt suffix)
    public func loadTextFile(name: String) {
        var result = ""
        
        let path = Bundle.main.path(forResource: name, ofType: "txt")
        if let path = path {
            do {
                result = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            } catch { }
        }
        
        if result != self.text {
            self.text = result
        }
    }
    
}

// MARK: Extension

public extension UIViewController {
    
    /// Returns an TextView with given referral id
    ///
    /// - Parameter referrral: String with name of TextView
    /// - Returns: Returns TextView with given name
    func findTextViewElement(with referrral: String) -> SlamTextView? {
        return findElement(with: referrral) as? SlamTextView
    }
    
}

