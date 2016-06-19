//
//  GroupTableViewCell.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    let frameHeight: CGFloat = 150
    let group: Group!

    var groupImage: UIImageView!
    var groupNameLabel: UILabel!
    var ownBalanceLabel: UILabel!
    var highestBalanceLabel: UILabel!
    var highestBalanceUserLabel: UILabel!
    var lowestBalanceLabel: UILabel!
    var lowestBalanceUserLabel: UILabel!

    init(group: Group, style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.group = group
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: SETTINGS.screenWidth, height: frameHeight)

        createInfoLabels()
        createOwnBalanceLabels()
        createHighestBalanceLabels()
        createLowestBalanceLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createInfoLabels() {
        groupNameLabel = UILabel(frame: CGRect(x: 8, y: 8, width: frame.width / 2, height: 25))
        groupNameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)
        groupNameLabel.text = group.name

        let infoSeparator = UIView(frame: CGRect(x: 8, y: 75, width: frame.width, height: 1))
        infoSeparator.backgroundColor = UIColor(colorCode: "C2C2C2")

        addSubview(groupNameLabel)
        addSubview(infoSeparator)
    }

    private func createOwnBalanceLabels() {
        let ownBalanceInfoLabel = UILabel(frame: CGRect(x: 8, y: 85, width: frame.width / 3 - 16, height: 17.5))
        ownBalanceInfoLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 13)
        ownBalanceInfoLabel.text = "Mijn stand"
        ownBalanceInfoLabel.textAlignment = .Center

        ownBalanceLabel = UILabel(frame: CGRect(x: 8, y: 115, width: ownBalanceInfoLabel.frame.width, height: 17.5))
        ownBalanceLabel.font = UIFont(name: "HelveticaNeue-Lighter", size: 15)
        ownBalanceLabel.text = "€" + group.ownBalance
        ownBalanceLabel.textAlignment = .Center

        let verticalSeparator = UIView(frame: CGRect(x: ownBalanceLabel.frame.maxX + 4, y: 80, width: 1, height: frame.height - 85))
        verticalSeparator.backgroundColor = UIColor(colorCode: "C2C2C2")

        addSubview(ownBalanceInfoLabel)
        addSubview(ownBalanceLabel)
        addSubview(verticalSeparator)
    }

    private func createHighestBalanceLabels() {
        let highestBalanceInfoLabel = UILabel(frame: CGRect(x: ownBalanceLabel.frame.maxX + 8, y: 85, width: frame.width / 3 - 16, height: 17.5))
        highestBalanceInfoLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 13)
        highestBalanceInfoLabel.text = "Hoogste stand"
        highestBalanceInfoLabel.textAlignment = .Center

        highestBalanceLabel = UILabel(frame: CGRect(x: highestBalanceInfoLabel.frame.minX, y: 115, width: highestBalanceInfoLabel.frame.width, height: 17.5))
        highestBalanceLabel.font = UIFont(name: "HelveticaNeue-Lighter", size: 15)
        highestBalanceLabel.text = "€" + group.highestBalance
        highestBalanceLabel.textAlignment = .Center

        let verticalSeparator = UIView(frame: CGRect(x: highestBalanceInfoLabel.frame.maxX + 4, y: 80, width: 1, height: frame.height - 85))
        verticalSeparator.backgroundColor = UIColor(colorCode: "C2C2C2")

        addSubview(highestBalanceInfoLabel)
        addSubview(highestBalanceLabel)
        addSubview(verticalSeparator)
    }

    private func createLowestBalanceLabels() {
        let lowestBalanceInfoLabel = UILabel(frame: CGRect(x: highestBalanceLabel.frame.maxX + 8, y: 85, width: frame.width / 3 - 16, height: 17.5))
        lowestBalanceInfoLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 13)
        lowestBalanceInfoLabel.text = "Laagste stand"
        lowestBalanceInfoLabel.textAlignment = .Center

        lowestBalanceLabel = UILabel(frame: CGRect(x: lowestBalanceInfoLabel.frame.minX, y: 115, width: lowestBalanceInfoLabel.frame.width, height: 17.5))
        lowestBalanceLabel.font = UIFont(name: "HelveticaNeue-Lighter", size: 15)
        lowestBalanceLabel.text = "€" + group.lowestBalance
        lowestBalanceLabel.textAlignment = .Center

        addSubview(lowestBalanceInfoLabel)
        addSubview(lowestBalanceLabel)
    }

}