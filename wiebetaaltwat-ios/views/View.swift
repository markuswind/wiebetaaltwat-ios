//
//  View.swift
//  parkeerpas-ios
//
//  Created by Markus Wind on 20/05/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Foundation
import UIKit

class View: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func setMargins(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        frame = CGRect(
            x: frame.minX + left,
            y: frame.minY + top,
            width: frame.width - (left + right),
            height:frame.height - (bottom + top)
        )
    }

    func setPadding(dx: CGFloat, dy: CGFloat) {
        bounds = CGRectInset(frame, dx, dy)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}