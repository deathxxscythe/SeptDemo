//
//  WebKitView.swift
//  animeProject
//
//  Created by Nathaniel Patterson on 10/31/21.
//

import Foundation
import UIKit
import WebKit


class WebKitView: UIViewController {
    var coordinator: Coordinator!
    var webView: WKWebView!
    var url: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

extension WebKitView: WKNavigationDelegate {
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        webView.load(URLRequest(url: URL(string: url ?? "")!))
        webView.allowsBackForwardNavigationGestures = true
    }
}
