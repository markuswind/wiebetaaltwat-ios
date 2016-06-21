//
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
        let navigationController = NavigationController()
        var loginViewController = LoginViewController(user: nil)

        if let user = retrieveSavedUser() {
            loginViewController = LoginViewController(user: user)
        }

        navigationController.viewControllers.append(loginViewController)

        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()

        return true
    }

    private func retrieveSavedUser() -> User? {
        var user: User?

        let userdefaults = NSUserDefaults.standardUserDefaults()
        let data = userdefaults.objectForKey("user")

        if let data = data as? NSData {
            user = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? User
        }
        
        return user
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