//
//  LogoHeaderView.swift
//  parkeerpas-ios
//
//  Created by Markus Wind on 21/05/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Foundation
import UIKit

class LogoHeaderView: View {

    override init(frame: CGRect) {
        super.init(frame: frame)

        // add border
        layer.borderColor = UIColor(colorCode: "DADCD7").CGColor
        layer.borderWidth = 1.0

        // create logo
        let aspectwidth = frame.height * 0.75

        let logoImageView = UIImageView(frame: CGRect(x: frame.midX - (aspectwidth / 2), y: frame.midY - (aspectwidth / 2), width: aspectwidth, height: aspectwidth))
        logoImageView.image = UIImage(named: "wiebetaaltwat-logo.png")
        logoImageView.contentMode = .ScaleAspectFit

        // done
        addSubview(logoImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}