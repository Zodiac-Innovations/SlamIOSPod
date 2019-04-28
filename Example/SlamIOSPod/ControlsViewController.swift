//
//  ControlsViewController.swift
//  SlamIOSPod_Example
//
//  Created by Steve Sheets on 4/23/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
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
        
        // MARK: Section One
        
        // Set Light label update so using the lightFlag, the text On or Off is shown
        
        if let light = self.findLabelElement(with: "light") {
            light.textDataSource = {
                return self.lightFlag ? "Light On" : "Light Off"
            }
        }
        
        // Set the flip button so press it flips lightFlag, and update everyones UI
        
        if let flip = self.findButtonElement(with: "flip") {
            flip.pressActionBlock = {
                self.lightFlag = !self.lightFlag
                
                self.counterLimit = self.lightFlag ? 10 : 5
                self.counter = (self.counter > self.counterLimit) ? self.counterLimit : self.counter
            }
        }
        
        // MARK: Section Two
        
        // Knob is only active if flag is on
        
        if let knob = self.findSwitchElement(with: "knob") {
            knob.enableDataSource = {
                return self.lightFlag
            }
            knob.switchDataSource = {
                return self.leverFlag
            }
            knob.pressActionBlock = {
                self.leverFlag = knob.isOn
            }
        }
        
        // Set lever label update so using the knob setting, the leverFlag Open or Lever Closed is shown, while enabled using lightFlag
        if let lever = self.findLabelElement(with: "lever") {
            lever.textDataSource = {
                if self.lightFlag {
                    return self.leverFlag ? "Lever Open" : "Lever Closed"
                }
                else {
                    return "Lever disabled"
                }
            }
        }
        
        // Set Activity Indicator animation and visibility to Flag & knob
        
        if let act = self.findActivityIndicatorViewElement(with: "act") {
            act.visibleDataSource = {
                return self.lightFlag
            }
            act.animatingDataSource = {
                return self.lightFlag && self.leverFlag
            }
        }
        
        // MARK: Section Three
        
        // Set Count label update so using the knob setting, the text Lever Open or Lever Closed is shown
        
        if let count = self.findLabelElement(with: "count") {
            count.textDataSource = {
                return "Count: " + String(self.counter) + " of " + String(self.counterLimit)
            }
        }
        
        // Set the stepper Max based on Flag
        
        if let step = self.findStepperElement(with: "step") {
            step.maxValueDataSource = {
                return Double(self.counterLimit)
            }
            step.valueDataSource = {
                return Double(self.counter)
            }
            step.pressActionBlock = {
                self.counter = Int(step.value)
            }
        }
        
        // Set the progess uses stepper & flag
        
        if let prog = self.findProgressViewElement(with: "prog") {
            prog.progresDataSource = {
                if let step = self.findStepperElement(with: "step") {
                    let n = step.value
                    let limit = self.lightFlag ? 10.0 : 5.0
                    
                    return n / limit
                }
                
                return 0.0
            }
        }
        
        // MARK: Section Four
        
        // Set segment control content
        
        if let seg = self.findSegmentedControlElement(with: "seg") {
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
        }
        
        // Set segment label using seg
        
        if let segcount = self.findLabelElement(with: "segcount") {
            segcount.textDataSource = {
                return "Item: " + String(self.sectionNumber+1)
            }
        }
        
        // Set the page control so press changes the Stepper value
        
        if let page = self.findPageControlElement(with: "page") {
            page.pressActionBlock = {
                self.sectionNumber = page.currentPage
            }
            page.maxPageDataSource = {
                return self.lightFlag ? 4 : 3
            }
            page.currentPageDataSource = {
                return self.sectionNumber
            }
        }
        
        updateMainUI()
    }

}
