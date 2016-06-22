//
//  GroupLiquidationTableViewCell.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/22/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class GroupLiquidationTableViewCell: UITableViewCell {

    let frameHeight: CGFloat = 80
    let liquidation: Liquidation!

    var nameLabel: UILabel!
    var bankAccountLabel: UILabel!
    var balanceLabel: UILabel!

    init(liquidation: Liquidation, style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.liquidation = liquidation
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: SETTINGS.screenWidth, height: frameHeight)

        createUserLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createUserLabels() {
        nameLabel = UILabel(frame: CGRect(x: 8, y: 8, width: frame.width / 2 - 16, height: 20))
        nameLabel.text = liquidation.liquidationUser.name

        bankAccountLabel = UILabel(frame: CGRect(x: 8, y: nameLabel.frame.maxY, width: nameLabel.frame.width, height: 20))
        bankAccountLabel.text = liquidation.liquidationUser.bankAccount

        balanceLabel = UILabel(frame: CGRect(x: 8, y: bankAccountLabel.frame.maxY, width: nameLabel.frame.width, height: 20))
        balanceLabel.text = liquidation.liquidationUser.balance

        addSubview(nameLabel)
        addSubview(bankAccountLabel)
        addSubview(balanceLabel)
    }

}