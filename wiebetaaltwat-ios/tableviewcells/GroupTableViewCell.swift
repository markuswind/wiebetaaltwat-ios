//
//  GroupTableViewCell.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    let group: Group!

    var groupNameLabel: UILabel!
    var ownBalanceLabel: UILabel!
    var highestBalanceLabel: UILabel!
    var highestBalanceUserLabel: UILabel!
    var lowestBalanceLabel: UILabel!
    var lowestBalanceUserLabel: UILabel!

    init(group: Group, style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.group = group
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: SETTINGS.screenWidth, height: 150)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}