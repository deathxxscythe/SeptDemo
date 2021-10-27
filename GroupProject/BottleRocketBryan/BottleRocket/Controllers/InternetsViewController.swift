//
//  internets.swift
//  BottleRocket
//
//  Created by Bryan Lee on 10/20/21.
//

import WebKit
import UIKit

class InternetsViewController : UIViewController, WKNavigationDelegate {
    
    private let webView = WKWebView()
    
    override func loadView() {
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        displayWeb()
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 67/255, green: 232/255, blue: 149/255, alpha: 1)
        
        // We can make the UI more intuitive by disabling and enabling backButton and forwardButton using canGoBack and canGoForward
        
        let backButton = UIBarButtonItem(
            image: UIImage(named: AssetsName.webBack),
            style: .plain,
            target: self.webView,
            action: #selector(WKWebView.goBack))
        backButton.tintColor = UIColor.white
        
        let refreshButton = UIBarButtonItem(
            image: UIImage(named: AssetsName.webRefresh),
            style: .plain,
            target: self.webView,
            action: #selector(WKWebView.reload))
        refreshButton.tintColor = UIColor.white
        
        let forwardButton = UIBarButtonItem(
            image: UIImage(named: AssetsName.webForward),
            style: .plain,
            target: self.webView,
            action: #selector(WKWebView.goForward))
        forwardButton.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItems = [backButton, refreshButton, forwardButton]
    }
    
    private func displayWeb() {
        guard let url = URL(string: NetworkConstants.webViewUrl) else {
            return
        }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
