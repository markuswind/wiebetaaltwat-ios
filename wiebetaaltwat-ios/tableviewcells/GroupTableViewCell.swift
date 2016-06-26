//
//  GroupTableViewCell.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    let frameHeight: CGFloat = 140
    let padding: CGFloat = 8
    let group: Group!

    var view: UIView!

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
        createLowestBalanceLabels()
        createHighestBalanceLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createInfoLabels() {
        groupImage = UIImageView(frame: CGRect(x: 8, y: 8, width: 50, height: 50))
        groupImage.setImageWithString(group.name, color: group.name.alphaBetColor(), circular: true)

        groupNameLabel = UILabel(frame: CGRect(x: groupImage.frame.maxX + 8, y: 8, width: frame.width - 74, height: 25))
        groupNameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 17.5)
        groupNameLabel.text = group.name

        ownBalanceLabel = UILabel(frame: CGRect(x: groupNameLabel.frame.minX, y: groupNameLabel.frame.maxY, width: groupNameLabel.frame.width, height: 25))
        ownBalanceLabel.font = UIFont(name: "HelveticaNeue-Lighter", size: 17.5)
        ownBalanceLabel.text = "€" + group.ownBalance

        addSubview(groupImage)
        addSubview(groupNameLabel)
        addSubview(ownBalanceLabel)
    }

    private func createLowestBalanceLabels() {
        let lowestBalanceInfoLabel = UILabel(frame: CGRect(x: ownBalanceLabel.frame.minX, y: groupImage.frame.maxY + 8, width: groupNameLabel.frame.width / 2, height: 15))
        lowestBalanceInfoLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        lowestBalanceInfoLabel.text = "Laagste stand"

        lowestBalanceUserLabel = UILabel(frame: CGRect(x: lowestBalanceInfoLabel.frame.minX, y: lowestBalanceInfoLabel.frame.maxY + 4, width: lowestBalanceInfoLabel.frame.width, height: lowestBalanceInfoLabel.frame.height))
        lowestBalanceUserLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        lowestBalanceUserLabel.text = group.lowestBalanceUser

        lowestBalanceLabel = UILabel(frame: CGRect(x: lowestBalanceInfoLabel.frame.minX, y: lowestBalanceUserLabel.frame.maxY + 4, width: lowestBalanceInfoLabel.frame.width, height: lowestBalanceInfoLabel.frame.height))
        lowestBalanceLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 14.0)
        lowestBalanceLabel.text = "€" + group.lowestBalance
        lowestBalanceLabel.textColor = UIColor(colorCode: "F64747")

        addSubview(lowestBalanceInfoLabel)
        addSubview(lowestBalanceUserLabel)
        addSubview(lowestBalanceLabel)
    }

    private func createHighestBalanceLabels() {
        let highestBalanceInfoLabel = UILabel(frame: CGRect(x: lowestBalanceLabel.frame.maxX, y: groupImage.frame.maxY + 8, width: groupNameLabel.frame.width / 2, height: 15))
        highestBalanceInfoLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        highestBalanceInfoLabel.text = "Hoogste stand"

        highestBalanceUserLabel = UILabel(frame: CGRect(x: highestBalanceInfoLabel.frame.minX, y: highestBalanceInfoLabel.frame.maxY + 4, width: highestBalanceInfoLabel.frame.width, height: highestBalanceInfoLabel.frame.height))
        highestBalanceUserLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        highestBalanceUserLabel.text = group.highestBalanceUser

        highestBalanceLabel = UILabel(frame: CGRect(x: highestBalanceInfoLabel.frame.minX, y: highestBalanceUserLabel.frame.maxY + 4, width: highestBalanceInfoLabel.frame.width, height: highestBalanceInfoLabel.frame.height))
        highestBalanceLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 14.0)
        highestBalanceLabel.text = "€" + group.highestBalance
        highestBalanceLabel.textColor = UIColor(colorCode: "3FC380")

        addSubview(highestBalanceInfoLabel)
        addSubview(highestBalanceUserLabel)
        addSubview(highestBalanceLabel)
    }
}