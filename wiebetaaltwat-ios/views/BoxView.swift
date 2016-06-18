//
//  BoxView.swift
//  parkeerpas-ios
//
//  Created by Markus Wind on 20/05/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Foundation
import UIKit

class BoxView: View {

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height))

        createBoxView()
    }

    override func setMargins(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        super.setMargins(top, bottom: bottom, left: left, right: right)
    }

    private func createBoxView() {
        backgroundColor = UIColor.whiteColor() // UIColor(colorCode: "F3F4F2")

        layer.borderColor = UIColor(colorCode: "DADCD7").CGColor
        layer.borderWidth = 1.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}