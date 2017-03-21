//
//  AppDelegate.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/18.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let rootVC = UIStoryboard(name: "AreaSelectViewController",bundle: nil).instantiateInitialViewController() as! AreaSelectViewController
        
        navigationController = UINavigationController(rootViewController: rootVC)
        self.window?.rootViewController = navigationController
        
        return true
    }
}

