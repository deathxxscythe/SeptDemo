//
//  Coordinator.swift
//  animeProject
//
//  Created by Nathaniel Patterson on 10/30/21.
//

import Foundation
import UIKit

class Coordinator {
    var navCon = UINavigationController()
    
    func pushHomeVC() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let mainVC = sb.instantiateViewController(identifier: "mainVC") as? ViewController {
            mainVC.delegate = self
            navCon.pushViewController(mainVC, animated: true)
        }
    }
    
    func pushWebKit(url: String) {
        let sb = UIStoryboard(name: "WebKitView", bundle: nil)
        if let webKitView = sb.instantiateViewController(withIdentifier: "webKit" ) as? WebKitView {
            webKitView.coordinator = self
            webKitView.url = url
            navCon.pushViewController(webKitView, animated: true)
        }
    }
}
