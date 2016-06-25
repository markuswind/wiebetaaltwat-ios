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
        backgroundColor = UIColor(colorCode: "F4F4F4")
        accessoryType = .DisclosureIndicator

        view = UIView(frame: CGRect(x: padding, y: padding, width: frame.width - padding * 2, height: frame.height - padding * 2))
        view.backgroundColor = UIColor.whiteColor()
        addSubview(view)

        createInfoLabels()
//        createLowestBalanceLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createInfoLabels() {
        groupImage = UIImageView(frame: CGRect(x: 8, y: 8, width: 50, height: 50))
        groupImage.setImageWithString(group.name, color: group.name.alphaBetColor(), circular: true)

        groupNameLabel = UILabel(frame: CGRect(x: groupImage.frame.maxX + 8, y: 8, width: frame.width / 2, height: 25))
        groupNameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 17.5)
        groupNameLabel.text = group.name

        ownBalanceLabel = UILabel(frame: CGRect(x: groupNameLabel.frame.minX, y: groupNameLabel.frame.maxY, width: view.frame.width / 2, height: 25))
        ownBalanceLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 17.5)
        ownBalanceLabel.text = "€" + group.ownBalance

        view.addSubview(groupImage)
        view.addSubview(groupNameLabel)
        view.addSubview(ownBalanceLabel)
    }

    private func createLowestBalanceLabels() {
        lowestBalanceLabel = UILabel(frame: CGRect(x: groupImage.frame.maxX + 8, y: groupNameLabel.frame.maxY + 4, width: view.frame.width * 0.3, height: 15))
        lowestBalanceLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 10.0)
        lowestBalanceLabel.text = "Laagste stand"

        view.addSubview(lowestBalanceLabel)
    }
}