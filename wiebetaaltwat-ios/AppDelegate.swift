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
        window!.rootViewController = LoginViewController()
        window!.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {
        // TODO:: check if possible to set timers for notifications
        //        if so, maybe check card state if active?
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // TODO:: login cards in cardoverviewcontroller again (here?)
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // TODO:: login cards in cardoverviewcontroller (or maybe here?)
    }
    
    func applicationWillTerminate(application: UIApplication) {
        
    }
    
}