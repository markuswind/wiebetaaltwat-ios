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

    override func viewDidLoad() {
        navigationBar.tintColor = UIColor(colorCode: "FFFFFF")
        navigationBar.barTintColor = UIColor(colorCode: "6d3212")
        navigationBar.barStyle = .Black
    }
    
}