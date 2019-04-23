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
public class SlamSingleItemTableView: UITableView, SlamViewProtocol, SlamResetProtocol, UITableViewDataSource, UITableViewDelegate {

    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    public var visibleDataSource: Slam.FlagClosure?
    
    // MARK: Computed Properties
    
    /// Current selectiom (zero based). Nil means no selections.
    var currentSelection: Int? {
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
    var staticListLabels: Slam.StringArray?
    
    /// Optional data closure for selected label (zero based). Nil means no selections.
    var selectedDataSource: Slam.OptionalIntClosure?
    
    /// Optional data closure for list to use for labels
    var labelsDataSource: Slam.StringArrayClosure?
    
    /// Optional data source closure for number of items in table view.
    var itemsForDataSource: Slam.IntClosure?
    
    /// Optional data source closure for number of items in table view.
    var stringForItemDataSource: Slam.SlamStringForIntClosure?
    
    /// Invoked when selection occurs
    var selectEventBlock: Slam.ActionClosure?

    // MARK: Protocol Methods
    
    public func fillUI() {
    }
    
    public func reloadUI() {
        reloadData()
    }
    
    // MARK: Lifecycle Methods
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.dataSource = self
        self.delegate = self
        
        self.allowsSelection = true
        self.allowsMultipleSelection = false
    }
    
    required init?(coder aDecoder: NSCoder) {
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

extension UIViewController {
    
    /// Returns an TableView with given referral id
    ///
    /// - Parameter referrral: String with name of TableView
    /// - Returns: Returns TableView with given name
    func findSingleItemTableViewElement(with referrral: String) -> SlamSingleItemTableView? {
        return findElement(with: referrral) as? SlamSingleItemTableView
    }
    
}
