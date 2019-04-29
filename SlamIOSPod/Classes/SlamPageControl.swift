//
//  SlamPageControl.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/18/19.
//  Copyright © 2019 Zodiac Innovations. All rights reserved.
//

import UIKit

/// Closure based Page Control view
///
/// This class provides a closure based Pag Control view. It supports the SlamViewProtocol, SlamControlProtocol, and SlamInteractiveProtocol (with appropriate properties and functions).
///
/// The currentPageDataSource property contains a closure that calculates the current page (zero count), while the maxPageDataSource property has a closure for the max number of pages.  Either field can be nil, and the values are set directly.
public class SlamPageControl: UIPageControl, SlamControlProtocol, SlamInteractiveProtocol {

    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    @IBInspectable public var task: String = ""

    @IBInspectable public var param: String = ""

    @IBInspectable public var autoUI: Bool = false

    public var visibleDataSource: Slam.FlagClosure?
    
    public var enableDataSource: Slam.FlagClosure?
    
    public var pressActionBlock: Slam.ActionClosure?

    // MARK: Properties
    
    /// Optional data source closure for current page (zero count)
    public var currentPageDataSource: Slam.IntClosure?
    
    /// Optional data source closure for current page
    public var maxPageDataSource: Slam.IntClosure?

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
        if let maxPageDataSource = maxPageDataSource {
            let value = maxPageDataSource()
            
            if value != self.numberOfPages {
                self.numberOfPages = value
            }
        }
        
        if let currentPageDataSource = currentPageDataSource {
            let value = currentPageDataSource()
            
            if value != self.currentPage {
                self.currentPage = value
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
    
    /// Returns an PageControl with given referral id
    ///
    /// - Parameter referrral: String with name of PageControl
    /// - Returns: Returns PageControl with given name
    func findPageControlElement(with referrral: String) -> SlamPageControl? {
        return findElement(with: referrral) as? SlamPageControl
    }
    
}
