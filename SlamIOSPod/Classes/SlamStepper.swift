//
//  SlamStepper.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/18/19.
//  Copyright © 2019 Zodiac Innovations. All rights reserved.
//

import UIKit

// MARK: Class

/// Closure based Stepper view
public class SlamStepper: UIStepper, SlamControlProtocol, SlamInteractiveProtocol {

    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    @IBInspectable public var task: String = ""

    @IBInspectable public var param: String = ""

    @IBInspectable public var autoUI: Bool = false

    public var visibleDataSource: Slam.FlagClosure?
    
    public var enableDataSource: Slam.FlagClosure?
    
    public var pressActionBlock: Slam.ActionClosure?

    // MARK: Computed Properties
    
    // MARK: Properties
    
    /// Optional data source closure for min value of stepper
    public var minValueDataSource: Slam.DoubleClosure?
    
    /// Optional data source closure for max value of stepper
    public var maxValueDataSource: Slam.DoubleClosure?
    
    /// Optional data source closure for value of stepper (min to max inclusive)
    public var valueDataSource: Slam.DoubleClosure?
    
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
        if let minValueDataSource = minValueDataSource {
            let n = minValueDataSource()
            
            if n != self.minimumValue {
                self.minimumValue = n
            }
        }
        
        if let maxValueDataSource = maxValueDataSource {
            let n = maxValueDataSource()
            
            if n != self.maximumValue {
                self.maximumValue = n
            }
        }
        
        if let valueDataSource = valueDataSource {
            let n = valueDataSource()
            
            if n != self.value {
                self.value = n
            }
        }
    }
    
    // MARK: Private Methods
    
    /// Action method invoked when view is pressed. It invokes the closure.
    @objc func press(sender: UIView) {
        pressAction()
    }
}

// MARK: Extension

extension UIViewController {
    
    /// Returns an Stepper with given referral id
    ///
    /// - Parameter referrral: String with name of Stepper
    /// - Returns: Returns Stepper with given name
    func findStepperElement(with referrral: String) -> SlamStepper? {
        return findElement(with: referrral) as? SlamStepper
    }
    
}
