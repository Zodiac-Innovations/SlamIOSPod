//
//  ExampleViewController.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 04/15/2019.
//  Copyright (c) 2019 Steve Sheets. All rights reserved.
//

import UIKit
import SlamIOSPod

class ExampleViewController: UIViewController {
    
    @IBOutlet weak var lightButton: SlamButton?
    
    @IBOutlet weak var lightLabel: SlamLabel?
    
    var lightFlag = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lightButton?.pressActionBlock = {
            self.lightFlag = !self.lightFlag
            
            self.lightLabel?.updateUI()
        }
        
        self.lightLabel?.textDataSource = {
            if self.lightFlag {
                return "On"
            }
            else {
                return "Off"
            }
        }
        
        self.lightLabel?.updateUI()
    }
    
}

