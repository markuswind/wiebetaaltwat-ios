//
//  PaymentTableViewCell.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 19/06/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {

    let payment: Payment!

    var frameHeight: CGFloat = 110

    var userImage: UIImageView!
    var byLabel: UILabel!
    var amountLabel: UILabel!
    var dateLabel: UILabel!
    var descriptionLabel: UILabel!

    init(payment: Payment, style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.payment = payment
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        frameHeight = frameHeight + CGFloat(15 * ceil(Double(payment.participants.count) / 3.0) + 8)
        frame = CGRect(x: 0, y: 0, width: SETTINGS.screenWidth, height: frameHeight)

        createInfoLabels()
        createParticipantLabels()
    }

    private func createInfoLabels() {
        userImage = UIImageView(frame: CGRect(x: 8, y: 8, width: 40, height: 40))
        userImage.setImageWithString(payment.by, color: payment.by.alphaBetColor(), circular: true)

        byLabel = UILabel(frame: CGRect(x: userImage.frame.maxX + 8, y: 8, width: (frame.width - 48) * 0.5, height: 20))
        byLabel.text = payment.by

        amountLabel = UILabel(frame: CGRect(x: byLabel.frame.minX, y: byLabel.frame.maxY, width: byLabel.frame.width, height: 20))
        amountLabel.text = "€" + payment.amount

        // set datelabel
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        dateLabel = UILabel(frame: CGRect(x: frame.width - (frame.width - 64) * 0.3, y: 8, width: (frame.width - 56) * 0.3, height: 20))
        dateLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        dateLabel.text = dateFormatter.stringFromDate(payment.date)

        descriptionLabel = UILabel(frame: CGRect(x: byLabel.frame.minX, y: amountLabel.frame.maxY, width: frame.width - 64, height: 30))
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        descriptionLabel.text = payment.description

        addSubview(userImage)
        addSubview(amountLabel)
        addSubview(byLabel)
        addSubview(dateLabel)
        addSubview(descriptionLabel)
    }

    private func createParticipantLabels() {
        let participantInfolabel = UILabel(frame: CGRect(x: userImage.frame.maxX + 8, y: descriptionLabel.frame.maxY, width: descriptionLabel.frame.width, height: 15))
        participantInfolabel.font = UIFont(name: "HelveticaNeue-Medium", size: 10.0)
        participantInfolabel.text = "Deelnemers:"

        // create participantbox
        let numberOfRows = ceil(Double(payment.participants.count) / 3.0)
        let participantBox = UIView(frame: CGRect(x: participantInfolabel.frame.minX, y: participantInfolabel.frame.maxY, width: descriptionLabel.frame.width, height: 15 * CGFloat(numberOfRows)))

        // add all participants to box
        var index = 0
        var previous: UILabel?

        for participant in payment.participants {
            previous = addParticipantToBox(participantBox, previous: previous, index: index, participant: participant)

            index += 1
        }

        // done
        addSubview(participantInfolabel)
        addSubview(participantBox)
    }

    private func addParticipantToBox(box: UIView, previous: UILabel?, index: Int, participant: Participant) -> UILabel {
        let label = UILabel()

        let name = participant.name
        let amount = participant.amount

        if previous == nil {
            label.frame = CGRect(x: 0, y: 0, width: box.frame.width / 3, height: 15)
        } else if index % 3 == 0 {
            label.frame = CGRect(x: 0, y: previous!.frame.maxY, width: box.frame.width / 3, height: 15)
        } else {
            label.frame = CGRect(x: previous!.frame.maxX, y: previous!.frame.minY, width: box.frame.width / 3, height: 15)
        }

        label.font = UIFont(name: "HelveticaNeue-Light", size: 13.0)
        label.text = "\(name) - \(amount)x"

        box.addSubview(label)

        return label
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}