//
//  AppDelegate.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit
import SwiftyBeaver

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.tintColor = UIColor.orangeColor()

        // enable loggin
        setenv("XcodeColors", "YES", 0)

        let console = ConsoleDestination()
        log.addDestination(console)

        // set root viewcontroller
        window!.rootViewController = getFirstViewController()
        window!.makeKeyAndVisible()

        return true
    }

    private func getFirstViewController() -> UIViewController {
        let navigationController = NavigationController()
        let loginViewController = LoginViewController()

        navigationController.viewControllers.append(loginViewController)

        return navigationController
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {

    }

    func applicationWillEnterForeground(application: UIApplication) {

    }

    func applicationDidBecomeActive(application: UIApplication) {

    }
    
    func applicationWillTerminate(application: UIApplication) {
        
    }
    
}