//
//  SlamWebView.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/19/19.
//  Copyright © 2019 Zodiac Innovations. All rights reserved.
//

import UIKit
import WebKit

// MARK: Class

/// Closure based Web View
///
/// This class has a number of new properties & closures.  The properties currentURL & currentTitle return their respective values.  The urlEventBlock event closure is invoked when the website URL has changed, while the titleEventBlock event closure is invoked when the title changes. The showSite(address:) function will try to load a webpage address, while the showFile(path:suffix:) method loads a local file.  The showFragment(html:) method load the given string as if it was HTML. FInally, clearSite() method sets the webpage to blank.
public class SlamWebView: WKWebView, WKNavigationDelegate, WKUIDelegate, SlamViewProtocol {

    // MARK: Protocol Properties
    
    @IBInspectable public var referral: String = ""
    
    public var visibleDataSource: Slam.FlagClosure?
    
    // MARK: Properties

    /// Current URL
    public var currentURL = ""
    
    /// Current Title
    public var currentTitle = ""
    
    /// Closure for URL change event
    public var urlEventBlock: Slam.ActionClosure? = nil
    
    /// Closure for Title change event
    public var titleEventBlock: Slam.ActionClosure? = nil
    
    // MARK: Computed Properties
    
    /// Safe access to web title, if undefined, will return empty string
    public var webTitle: String {
        if let titleString = title {
            return titleString
        }
        
        return ""
    }

    /// Safe access to url path string, if undefined, will return empty string
    public var webURL: String {
        if let urlString = url?.absoluteString {
             if urlString == "about:blank" {
                return ""
            }

            return urlString
        }
        
        return ""
    }

    // MARK: Protocol Methods
    
    public func fillUI() {
    }
    
    // MARK: Lifecycle Methods
    
    override public init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        
        self.navigationDelegate = self
        self.uiDelegate = self
        self.allowsBackForwardNavigationGestures = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
        self.navigationDelegate = self
        self.uiDelegate = self
        self.allowsBackForwardNavigationGestures = true
    }
    
    // MARK: Public Methods
    
    /// Goto the given site
    ///
    /// - Parameter address: String containing address of site
    public func showSite(address: String) {
        guard let aURL = URL(string:address) else { return }

        let aRequest = URLRequest(url: aURL)
    
        self.load(aRequest)
    }
    
    /// Open Local File into Webview
    ///
    /// - Parameter path: String containing Path to local file.
    /// - Parameter suffix: String file extension for file.
    public func showFile(path: String, suffix: String = "html") {
        if let url = Bundle.main.url(forResource: path, withExtension: suffix) {
            loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
    }
    
    /// Open given html fragment into webview
    ///
    /// - Parameter html: String with HTML fragment
    public func showFragment(html: String) {
        loadHTMLString(html, baseURL: nil)
    }
    
    /// Clear the web page
    public func clearSite() {
        currentURL = ""
        currentTitle = ""
        showSite(address: "about:blank")
    }
    
    // MARK: Private Methods
    
    private func checkWebStatus() {
        if currentURL != webURL {
            currentURL = webURL
            
            if let urlEventBlock = urlEventBlock {
                urlEventBlock()
            }
        }
        
        if currentTitle != webTitle {
            currentTitle = webTitle
            
            if let titleEventBlock = titleEventBlock {
                titleEventBlock()
            }
        }
    }
    
    // MARK: Protocol Methods
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.checkWebStatus()
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.checkWebStatus()
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.checkWebStatus()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.checkWebStatus()
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.checkWebStatus()
    }

}

// MARK: Extension

public extension UIViewController {
    
    /// Returns an WebView with given referral id
    ///
    /// - Parameter referrral: String with name of WebView
    /// - Returns: Returns WebView with given name
    func findWebViewElement(with referrral: String) -> SlamWebView? {
        return findElement(with: referrral) as? SlamWebView
    }
    
}
