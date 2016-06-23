//
//  TabBarController.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/19/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import AnimatedTabBar
import UIKit

class TabBarController: RAMAnimatedTabBarController {

    override func viewDidLoad() {
        var viewControllers: [UIViewController] = []
        viewControllers.append(createGroupNavigationController())
        viewControllers.append(createUserNavigationController())
        viewControllers.append(createSettingsNavigationController())

        setViewControllers(viewControllers, animated: false)

        super.viewDidLoad()

        tabBar.tintColor = UIColor.orangeColor()
    }

    private func createGroupNavigationController() -> NavigationController {
        let groupOverViewController = GroupOverViewController()
        let groupNavigationController = NavigationController(rootViewController: groupOverViewController)
        groupOverViewController.tabBarItem = createTabBarItem("Lists", imagename: "tabicon-groups")

        return groupNavigationController
    }

    private func createUserNavigationController() -> NavigationController {
        let userViewController = UserViewController()
        let userNavigationController = NavigationController(rootViewController: userViewController)
        userViewController.tabBarItem = createTabBarItem("Me", imagename: "tabicon-user")

        return userNavigationController
    }

    private func createSettingsNavigationController() -> NavigationController {
        let settingsViewController = SettingsViewController()
        let settingsNavigationController = NavigationController(rootViewController: settingsViewController)
        settingsNavigationController.tabBarItem = createTabBarItem("Settings", imagename: "tabicon-settings")

        return settingsNavigationController
    }

    private func createTabBarItem(title: String, imagename: String) -> RAMAnimatedTabBarItem {
        let image = UIImage(named: imagename)?.imageWithRenderingMode(.AlwaysTemplate)

        let animation = RAMBounceAnimation()
        animation.textSelectedColor = UIColor.orangeColor()
        animation.iconSelectedColor = UIColor.orangeColor()

        let tabBarItem = RAMAnimatedTabBarItem(title: title, image: image, selectedImage: image)
        tabBarItem.iconColor = UIColor.grayColor()
        tabBarItem.textColor = UIColor.grayColor()
        tabBarItem.animation = animation

        return tabBarItem
    }

}