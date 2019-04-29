//
//  SlamSingleItemTableView.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/19/19.
//  Copyright © 2019 Zodiac Innovations. All rights reserved.
//

import UIKit

// MARK: Class

/// Closure based Table View
///
/// This class provides a closure based Switch view. It supports SlamViewProtocol and SlamResetProtocol (with appropriate properties and functions). Note that as a View that supports SlamResetProtocol, a reloadUI() method must be invoked to update the data (cells) stored in the view.
///
/// SlamSingleItemTableView is one of the more complex Views of the Framework, appropriate since Table Views are complex views. This subclass of UITableView is for a single section, text only TableViews, where at most one item can be selected (the most common use of Table Views).
///
/// The class supports a number of optional ways to fill the cells in the view.  The property staticListLabels has an array of strings that will be simply used by the cell. Alternatively, the closure property selectedDataSource calculates an array of strings that will be simply used by the cell. The third option is to use the itemsForDataSource and the stringForItemDataSource closures, that will return the number of cells and the text for each cell.  Any of these options can be used, but not more than one at a time.
///
/// The variable currentSelection contains an optional int. It returns the currently selected row (nil being none), while setting it, will set the currently selected cell (nil meaning no selected cells). The Int value is zero-based. When the inspectable selectUI property is set, changing the selected row causes an update of the entire view controller. The deselectAll(animated:) function deselects any currently selected cell.  The fetchLabel(position:) function returns the text of the given cell. Lastly, the selectEventBlock closure is invoked when the selection changes.
public class SlamSingleItemTableView: UITableView, SlamViewProtocol, SlamResetProtocol, UITableViewDataSource, UITableViewDelegate {

    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    public var visibleDataSource: Slam.FlagClosure?
    
    // MARK: Computed Properties
    
    /// Current selectiom (zero based). Nil means no selections.
    public var currentSelection: Int? {
        get {
            if let select = indexPathForSelectedRow {
                if let row = select.last {
                    return row
                }
            }
            return nil
        }
        set(newValue) {
            if let newValue = newValue {
                selectRow(at: IndexPath(index:newValue), animated: false, scrollPosition: .none)
            }
            else {
                deselectAll()
            }
        }
    }
    
    // MARK: Inspectable Properties
    
    /// If true, changing selection causes update
    @IBInspectable public var selectUI: Bool = false

    // MARK: Properties
    
    /// Optional list to use for labels
    public var staticListLabels: Slam.StringArray?
    
    /// Optional data closure for selected label (zero based). Nil means no selections.
    public var selectedDataSource: Slam.OptionalIntClosure?
    
    /// Optional data closure for list to use for labels
    public var labelsDataSource: Slam.StringArrayClosure?
    
    /// Optional data source closure for number of items in table view.
    public var itemsForDataSource: Slam.IntClosure?
    
    /// Optional data source closure for text of items in table view.
    public var stringForItemDataSource: Slam.SlamStringForIntClosure?
    
    /// Invoked when selection occurs
    public var selectEventBlock: Slam.ActionClosure?

    // MARK: Protocol Methods
    
    public func fillUI() {
    }
    
    public func reloadUI() {
        reloadData()
    }
    
    // MARK: Lifecycle Methods
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.dataSource = self
        self.delegate = self
        
        self.allowsSelection = true
        self.allowsMultipleSelection = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
        self.dataSource = self
        self.delegate = self
        
        self.allowsSelection = true
        self.allowsMultipleSelection = false
   }
    
    // MARK: Delegate Methods
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkSelection()
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        checkSelection()
    }
    
    // MARK: DataSource Methods
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let staticListLabels = staticListLabels {
            return staticListLabels.count
        }
        
        if let labelsDataSource = labelsDataSource {
            let list = labelsDataSource()
            return list.count
        }
        
        if let itemsForDataSource = itemsForDataSource {
            return itemsForDataSource()
        }
        
        return 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var pos = 0
        if let last = indexPath.last {
            pos = last
        }

        let label = fetchLabel(position: pos)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath)
        
        cell.textLabel?.text = label
        
        return cell
    }
    
    // MARK: Public Method
    
    public func deselectAll(animated: Bool = false) {
        if let index = indexPathForSelectedRow {
            self.deselectRow(at: index, animated: animated)
        }
    }
    
    /// Fetch the label used at given position
    ///
    /// - Parameter position: zero based Int
    /// - Returns: String found at position
    public func fetchLabel(position: Int) -> String {
        if let staticListLabels = staticListLabels {
            if position<staticListLabels.count {
                return staticListLabels[position]
            }
        }
        
        if let labelsDataSource = labelsDataSource {
            let list = labelsDataSource()
            if position<list.count {
                return list[position]
            }
        }
        
        if let stringForItemDataSource = stringForItemDataSource {
            return stringForItemDataSource(position)
        }
        
        return ""
    }
    
    // MARK: Private Method
    
    public func checkSelection() {
        if let selectEventBlock = selectEventBlock {
            selectEventBlock()
        }
        
        if selectUI {
            self.updateRootUI()
        }
    }


}

// MARK: Extension

public extension UIViewController {
    
    /// Returns an TableView with given referral id
    ///
    /// - Parameter referrral: String with name of TableView
    /// - Returns: Returns TableView with given name
    func findSingleItemTableViewElement(with referrral: String) -> SlamSingleItemTableView? {
        return findElement(with: referrral) as? SlamSingleItemTableView
    }
    
}
