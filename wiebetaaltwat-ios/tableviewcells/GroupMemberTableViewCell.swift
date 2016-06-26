//
//  GroupMemberTableViewCell.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/22/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class GroupMemberTableViewCell: UITableViewCell {

    let frameHeight: CGFloat = 50
    let index: String!
    let member: BalanceUser!

    var avaterImageView: UIImageView!
    var nameLabel: UILabel!
    var balanceLabel: UILabel!

    init(index: Int, member: BalanceUser, style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.index = String(index)
        self.member = member
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: SETTINGS.screenWidth, height: frameHeight)

//        createAvaterImage()
        createLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createAvaterImage() {
        avaterImageView = UIImageView(frame: CGRect(x: 8, y: 8, width: 25, height: 25))
        avaterImageView.setImageWithString(index, color: nil, circular: true)

        addSubview(avaterImageView)
    }

    private func createLabels() {
        // create balance icon
        let balanceIcon = UIImageView(frame: CGRect(x: 8, y: 8, width: 30, height: 30))

        if (member.balance.rangeOfString("-") != nil) {
            balanceIcon.image = UIImage(named: "minus.png")
        } else {
            balanceIcon.image = UIImage(named: "plus.png")
        }

        // create namelabel
        nameLabel = UILabel(frame: CGRect(x: balanceIcon.frame.maxX + 4, y: 4, width: frame.width - 16, height: 19))
        nameLabel.font = UIFont(name: "HelvetciaNeue-Light", size: 15)
        nameLabel.text = member.name

        // create balance label
        let balancelabel = UILabel(frame: CGRect(x: balanceIcon.frame.maxX + 4, y: nameLabel.frame.maxY + 4, width: frame.width - 40, height: 19))
        balancelabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        balancelabel.text = "€ \(member.balance)"

        // done
        addSubview(nameLabel)
        addSubview(balanceIcon)
        addSubview(balancelabel)
    }

}