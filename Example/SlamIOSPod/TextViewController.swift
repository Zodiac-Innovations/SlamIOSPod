//
//  TextViewController.swift
//  SlamIOSPod_Example
//
//  Created by Steve Sheets on 4/23/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SlamIOSPod

// View Controller Displaying Text Fields & Text Views
class TextViewController: UIViewController {

    var first = ""
    var last = ""
    var city = ""
    var state = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let l1 = findLabelElement(with: "L1"),
            let l2 = findLabelElement(with: "L2"),
            let t1 = findTextFieldElement(with: "T1"),
            let t2 = findTextFieldElement(with: "T2"),
            let info = findTextViewElement(with: "info"),
            let main = findTextViewElement(with: "main"),
            let seg = findSegmentedControlElement(with: "seg")
            else { return }
        
        l1.textDataSource = {
            return (seg.currentSegment == 0) ? "First:" : "City:"
        }
        
        l2.textDataSource = {
            return (seg.currentSegment == 0) ? "Last:" : "State:"
        }
        
        info.textDataSource = {
            (seg.currentSegment == 0) ? "Enter your given name." : "Enter your address."
        }
        
        main.textFileDataSource = {
            (seg.currentSegment == 0) ? "latin" : "english"
        }
        
        seg.pressActionBlock = {
            if let current = seg.currentSegment {
                if current == 0 {
                    self.city = t1.textValue
                    self.state = t2.textValue
                    t1.text = self.first
                    t2.text = self.last
                }
                else {
                    self.first = t1.textValue
                    self.last = t2.textValue
                    t1.text = self.city
                    t2.text = self.state
                }
            }
            else {
                t1.text = ""
                t2.text = ""
            }
            
            info.resetUI()
            main.resetUI()
        }
        
        resetMainUI()
    }
    
}
