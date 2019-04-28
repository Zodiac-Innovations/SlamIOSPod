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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SlamTask.addTask(name: "push") { param in
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: param)
            self.present(vc, animated: true, completion: nil)
        }
        
        SlamTask.addTask(name: "pop") { param in
            self.dismiss(animated: true)
        }
    }
    
}

