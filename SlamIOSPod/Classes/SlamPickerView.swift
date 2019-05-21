//
//  SlamPickerView.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 5/15/19.
//

import UIKit

public class SlamPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate, SlamViewProtocol, SlamResetProtocol {

    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    public var visibleDataSource: Slam.FlagClosure?
    
    // MARK: Protocol Methods
    
    public func fillUI() {
    }
    
    public func reloadUI() {
        self.reloadAllComponents()
    }
    
    // MARK: Lifecycle Methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.dataSource = self
        self.delegate = self
   }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
        self.dataSource = self
        self.delegate = self
    }
    
    // MARK: DataSource Methods
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }

    // MARK: Delegate Methods
    
    public func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return "One"
    }
}

// MARK: Extension

public extension UIViewController {
    
    /// Returns an PickerView with given referral id
    ///
    /// - Parameter referrral: String with name of PickerView
    /// - Returns: Returns PickerView with given name
    func findPickerViewElement(with referrral: String) -> SlamPickerView? {
        return findElement(with: referrral) as? SlamPickerView
    }
    
}
