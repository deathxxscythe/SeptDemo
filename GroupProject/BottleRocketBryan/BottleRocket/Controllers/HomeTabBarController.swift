//
//  HomeTabBarController.swift
//  BottleRocket
//
//  Created by Bryan Lee on 10/20/21.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayTabBar()
    }

    private func displayTabBar() {
        
        let lunchSB = UIStoryboard(name: TabBarConstants.lunchSB, bundle: nil)
        guard let lunchVC = lunchSB.instantiateViewController(identifier: TabBarConstants.lunchVCIdentifier) as? LunchViewController else { return }
        
        let vc1 = UINavigationController(rootViewController: lunchVC)
        let vc2 = UINavigationController(rootViewController: InternetsViewController())
        
        vc1.title = TabBarConstants.lunchTitle
        vc2.title = TabBarConstants.internetsTitle
        
        vc1.tabBarItem.image = UIImage(named: AssetsName.lunchTabBarIcon)
        vc2.tabBarItem.image = UIImage(named: AssetsName.internetsTabBarIcon)
        
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor.black
        
        setViewControllers([vc1, vc2], animated: true)
    }

}

