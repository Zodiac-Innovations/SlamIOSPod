//
//  WebViewController.swift
//  SlamIOSPod_Example
//
//  Created by Steve Sheets on 4/23/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SlamIOSPod

// View Controller Displaying Webview
class WebViewController: UIViewController {
   
    var site: Int? = nil
    
    var ok = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let web = self.findWebViewElement(with: "webs"),
            let seg = self.findSegmentedControlElement(with: "seg"),
            let titleLabel = self.findLabelElement(with: "titlelabel"),
            let urlLabel = self.findLabelElement(with: "urllabel")
            else { return }
        
        titleLabel.textDataSource = {
            let s = web.webTitle
            if s.isEmpty {
                return ""
            }
            return "Title: " + s
            
        }
        
        urlLabel.textDataSource = {
            let s = web.webURL
            if s.isEmpty {
                return ""
            }
            return "URL: " + s
        }
        
        seg.labelArrayDataSource = {
            return ["Apple", "IMDB", "CNN", "Code"]
        }
        seg.pressActionBlock = {
            if self.site != seg.currentSegment {
                self.site = seg.currentSegment
                
                if let site = self.site {
                    if site == 0 {
                        web.showSite(address: "https://www.apple.com")
                    }
                    else if site == 1 {
                        web.showSite(address: "https://www.imdb.com")
                    }
                    else if site == 2 {
                        web.showSite(address: "https://www.cnn.com")
                    }
                    else if site == 3 {
                        web.showFragment(html: """
<html> <head> <title>Welcome</title> </head> <body> <h1>Hello, World!</h1> </body> </html>
""")
                    }
                }
                else {
                    web.clearSite()
                }
            }
        }
        seg.currentSegmentDataSource = {
            return self.site
        }
        
        web.titleEventBlock = {
            titleLabel.updateUI()
        }
        web.urlEventBlock = {
            urlLabel.updateUI()
        }
        
        updateMainUI()
    }

}
