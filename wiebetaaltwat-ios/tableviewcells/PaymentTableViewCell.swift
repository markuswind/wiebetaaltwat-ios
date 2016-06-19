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

    var amountLabel: UILabel!
    var byLabel: UILabel!
    var dateLabel: UILabel!
    var descriptionLabel: UILabel!

    init(payment: Payment, style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.payment = payment
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: SETTINGS.screenWidth, height: frameHeight)

        createLabels()
    }

    private func createLabels() {
        amountLabel = UILabel(frame: CGRect(x: 8, y: 8, width: frame.width / 4, height: 20))
        amountLabel.text = "€" + payment.amount

        byLabel = UILabel(frame: CGRect(x: 8, y: amountLabel.frame.maxY + 8, width: frame.width / 4, height: 20))
        byLabel.text = payment.by

        // set datelabel
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        dateLabel = UILabel(frame: CGRect(x: frame.maxX - frame.width / 3 - 8, y: 8, width: frame.width / 3, height: 20))
        dateLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        dateLabel.textAlignment = .Right
        dateLabel.text = dateFormatter.stringFromDate(payment.date)

        descriptionLabel = UILabel(frame: CGRect(x: 8, y: byLabel.frame.maxY + 8, width: frame.width / 2, height: 20))
        descriptionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        descriptionLabel.text = payment.description

        addSubview(amountLabel)
        addSubview(byLabel)
        addSubview(dateLabel)
        addSubview(descriptionLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}