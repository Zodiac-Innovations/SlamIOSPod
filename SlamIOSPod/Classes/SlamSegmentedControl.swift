//
//  SlamSegmentedControl.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/19/19.
//  Copyright © 2019 Zodiac Innovations. All rights reserved.
//

import UIKit

// MARK: Class

/// Closure based Segmented Control
///
/// This class provides a closure based Segmented Control view. It supports the SlamViewProtocol, SlamControlProtocol, and SlamInteractiveProtocol (with appropriate properties and functions).
///
/// The currentSegmentDataSource property contains a closure that calculates the selected segment (zero-count), while the labelArrayDataSource property has a closure that returns an array of strings. These strings are used for the number of items in the segment, and their labels.
public class SlamSegmentedControl: UISegmentedControl, SlamControlProtocol, SlamInteractiveProtocol {
    
    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    @IBInspectable public var task: String = ""
    
    @IBInspectable public var param: String = ""

    @IBInspectable public var autoUI: Bool = false

    public var visibleDataSource: Slam.FlagClosure?
    
    public var enableDataSource: Slam.FlagClosure?

    public var pressActionBlock: Slam.ActionClosure?

    // MARK: Computed Properties
    
    // Calculates the current selected segment (zero based). This returns nil if no segmented is selected
    public var currentSegment: Int? {
        get {
            let seg = self.selectedSegmentIndex
            if seg == -1 {
                return nil
            }
            else if seg == UISegmentedControl.noSegment {
                return nil
            }
            
            return seg
        }
    }

    // MARK: Properties
    
    /// Optional data source closure for current segment (zero value), -1 no segments
    public var currentSegmentDataSource: Slam.OptionalIntClosure?
    
   /// Optional data source closure for active
    public var labelArrayDataSource: Slam.StringArrayClosure? = nil
    
    // MARK: Private Properties
    
    /// Copy of current labels
    private var currentLabels: Slam.StringArray = []
    
    // MARK: Lifecycle Methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(press(sender:)), for: .valueChanged)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addTarget(self, action: #selector(press(sender:)), for: .valueChanged)
    }
    
    // MARK: Protocol Methods
    
    public func fillUI() {
        if let labelArrayDataSource = labelArrayDataSource {
            let labels = labelArrayDataSource()
            
            if labels != currentLabels {
                let newCount = labels.count
                if labels.count == numberOfSegments {
                    for n in 0..<newCount {
                        setTitle(labels[n], forSegmentAt: n)
                    }
                }
                else {
                    let oldValue = self.selectedSegmentIndex
                    
                    removeAllSegments()
                    
                    for n in 0..<newCount {
                        insertSegment(withTitle: labels[n], at: n, animated: false)
                    }
                    
                    self.selectedSegmentIndex = newCount<oldValue ? newCount : oldValue
                }
                
                currentLabels = labels
            }
        }

        if let currentSegmentDataSource = currentSegmentDataSource {
            let value = currentSegmentDataSource()
            let oldSegment = self.selectedSegmentIndex
            if let value = value {
                if value != self.selectedSegmentIndex {
                    self.selectedSegmentIndex = value
                }
            }
            else {
                if oldSegment != -1 && oldSegment != UISegmentedControl.noSegment {
                    self.selectedSegmentIndex = -1
                }
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
    
    /// Returns an SegmentedControl with given referral id
    ///
    /// - Parameter referrral: String with name of SegmentedControl
    /// - Returns: Returns SegmentedControl with given name
    func findSegmentedControlElement(with referrral: String) -> SlamSegmentedControl? {
        return findElement(with: referrral) as? SlamSegmentedControl
    }
    
}
