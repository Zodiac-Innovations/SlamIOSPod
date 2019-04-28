//
//  TablesViewController.swift
//  SlamIOSPod_Example
//
//  Created by Steve Sheets on 4/23/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SlamIOSPod

// View Controller Displaying Table Views
class TablesViewController: UIViewController {

    var tableNum: Int? = 0
    
    var table: SlamSingleItemTableView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table = findSingleItemTableViewElement(with: "table")
        
        if let seg = self.findSegmentedControlElement(with: "seg") {
            seg.labelArrayDataSource = {
                return ["String", "Closure", "Best"]
            }
            seg.pressActionBlock = {
                self.tableNum = seg.currentSegment
                
                self.fillTable()
            }
        }
        
        if let title = self.findLabelElement(with: "title") {
            title.textDataSource = {
                if let num = self.tableNum {
                    if num == 0 {
                        return "Static String Array"
                    }
                    else if num == 1 {
                        return "String Array Closures"
                    }
                    else if self.tableNum == 2 {
                        return "Element Closures"
                    }
                }
                
                return ""
            }
        }
        
        if let footer = self.findLabelElement(with: "footer") {
            footer.textDataSource = {
                if let table = self.table {
                    if let num = self.table?.currentSelection {
                        return "Selected #" + String(num+1) + " = " + table.fetchLabel(position: num)
                    }
                }
                
                return "No Ideas"
            }
        }
        
        fillTable()
    }
    
    func fillTable() {
        if let table = table {
            table.staticListLabels = nil
            table.labelsDataSource = nil
            table.itemsForDataSource = nil
            table.stringForItemDataSource = nil
            
            if let tableNum = tableNum {
                if tableNum == 0 {
                    table.staticListLabels = ["Alpha", "Baker", "Charlie", "Delta", "Echo"]
                }
                else if tableNum==1 {
                    table.labelsDataSource = {
                        return ["Dwarf", "Elf", "Human (2)", "Hobbit (4)", "Wizard"]
                    }
                }
                else if tableNum==2 {
                    table.itemsForDataSource = {
                        return 3
                    }
                    table.stringForItemDataSource = { n in
                        if n == 0 {
                            return "Rock"
                        }
                        else if n == 1 {
                            return "Paper"
                        }
                        
                        return "Scissor"
                    }
                }
            }
        }
        
        resetMainUI()
    }

}
