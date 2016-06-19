//
//  PaymentTableViewCell.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 19/06/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {

    let frameHeight: CGFloat = 100
    let payment: Payment!

    init(payment: Payment, style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.payment = payment
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: SETTINGS.screenWidth, height: frameHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}