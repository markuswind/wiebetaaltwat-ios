//
//  GroupMemberTableViewCell.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/22/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class GroupMemberTableViewCell: UITableViewCell {

    let frameHeight: CGFloat = 40
    let member: BalanceUser!

    var avaterImageView: UIImageView!
    var nameLabel: UILabel!
    var balanceLabel: UILabel!

    init(member: BalanceUser, style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.member = member
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: SETTINGS.screenWidth, height: frameHeight)

        createAvaterImage()
        createLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createAvaterImage() {
        avaterImageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
        avaterImageView.backgroundColor = UIColor.purpleColor()

        addSubview(avaterImageView)
    }

    private func createLabels() {
        nameLabel = UILabel(frame: CGRect(x: avaterImageView.frame.maxX + 8, y: 5, width: frame.width - 16 - avaterImageView.frame.maxX, height: 15))
        nameLabel.text = member.name

        balanceLabel = UILabel(frame: CGRect(x: avaterImageView.frame.maxX + 8, y: nameLabel.frame.maxY, width: frame.width - 16 - avaterImageView.frame.maxX, height: 15))
        balanceLabel.text = member.balance

        addSubview(nameLabel)
        addSubview(balanceLabel)
    }

}