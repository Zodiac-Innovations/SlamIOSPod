//
//  ControlsViewController.swift
//  SlamIOSPod_Example
//
//  Created by Steve Sheets on 4/23/19.
//  Copyright © 2019 Steve Sheets. All rights reserved.
//

import UIKit
import SlamIOSPod

// View Controller Displaying Simple Views and Controls
class ControlsViewController: UIViewController {

    var lightFlag = false
    
    var leverFlag = false
    
    var sectionNumber = 0 // zero based
    
    var counterLimit = 5 // 5 or 10
    
    var counter = 0 // 0..Limit Range
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // guard to confirm the views
        
        guard let light = self.findLabelElement(with: "light"),
            let flip = self.findButtonElement(with: "flip"),
            let knob = self.findSwitchElement(with: "knob"),
            let lever = self.findLabelElement(with: "lever"),
            let act = self.findActivityIndicatorViewElement(with: "act"),
            let count = self.findLabelElement(with: "count"),
            let step = self.findStepperElement(with: "step"),
            let prog = self.findProgressViewElement(with: "prog"),
            let seg = self.findSegmentedControlElement(with: "seg"),
            let segcount = self.findLabelElement(with: "segcount"),
            let page = self.findPageControlElement(with: "page")
                else { return }
        
        // MARK: Section One
        
        // Set Light label update so using the lightFlag, the text On or Off is shown
        
        light.textDataSource = {
            return self.lightFlag ? "Light On" : "Light Off"
        }
        
        // Set the flip button so press it flips lightFlag, and update everyones UI
        
        flip.pressActionBlock = {
            self.lightFlag = !self.lightFlag
            
            self.counterLimit = self.lightFlag ? 10 : 5
            self.counter = (self.counter > self.counterLimit) ? self.counterLimit : self.counter
        }
        
        // MARK: Section Two
        
        // Knob is only active if flag is on
        
        knob.enableDataSource = {
            return self.lightFlag
        }
        knob.switchDataSource = {
            return self.leverFlag
        }
        knob.pressActionBlock = {
            self.leverFlag = knob.isOn
        }
        
        // Set lever label update so using the knob setting, the leverFlag Open or Lever Closed is shown, while enabled using lightFlag
        lever.textDataSource = {
            if self.lightFlag {
                return self.leverFlag ? "Lever Open" : "Lever Closed"
            }
            else {
                return "Lever disabled"
            }
        }
        
        // Set Activity Indicator animation and visibility to Flag & knob
        
        act.visibleDataSource = {
            return self.lightFlag
        }
        act.animatingDataSource = {
            return self.lightFlag && self.leverFlag
        }
        
        // MARK: Section Three
        
        // Set Count label update so using the knob setting, the text Lever Open or Lever Closed is shown
        
        count.textDataSource = {
            return "Count: " + String(self.counter) + " of " + String(self.counterLimit)
        }
        
        // Set the stepper Max based on Flag
        
        step.maxValueDataSource = {
            return Double(self.counterLimit)
        }
        step.valueDataSource = {
            return Double(self.counter)
        }
        step.pressActionBlock = {
            self.counter = Int(step.value)
        }
        
        // Set the progess uses stepper & flag
        
        prog.progresDataSource = {
            if let step = self.findStepperElement(with: "step") {
                let n = step.value
                let limit = self.lightFlag ? 10.0 : 5.0
                
                return n / limit
            }
            
            return 0.0
        }
        
        // MARK: Section Four
        
        // Set segment control content
        
        seg.labelArrayDataSource = {
            return self.lightFlag ? ["One", "Two", "Three", "Four"] : ["Alpha", "Beta", "Charlie"]
        }
        seg.pressActionBlock = {
            if let num = seg.currentSegment {
                self.sectionNumber = num
            }
            else {
                self.sectionNumber = 0
            }
        }
        seg.currentSegmentDataSource = {
            return self.sectionNumber
        }
        
        // Set segment label using seg
        
        segcount.textDataSource = {
            return "Item: " + String(self.sectionNumber+1)
        }
        
        // Set the page control so press changes the Stepper value
        
        page.pressActionBlock = {
            self.sectionNumber = page.currentPage
        }
        page.maxPageDataSource = {
            return self.lightFlag ? 4 : 3
        }
        page.currentPageDataSource = {
            return self.sectionNumber
        }
        
        updateMainUI()
    }

}
