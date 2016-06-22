//
//  NavigationController.swift
//  parkeerpas-ios
//
//  Created by Markus Wind on 5/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {

    var statusBarBackground: UIView!

    override func viewDidLoad() {
        navigationBar.translucent = false
        navigationBar.shadowImage = UIImage();
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)

        navigationBar.tintColor = UIColor(colorCode: "FFFFFF")
        navigationBar.barTintColor = UIColor(colorCode: "FF8000")
        navigationBar.barStyle = .Black
    }

}