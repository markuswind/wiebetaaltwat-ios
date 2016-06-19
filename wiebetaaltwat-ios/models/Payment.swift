//
//  Payment.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/19/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Foundation

class Participant {

    let name: String
    let amount: Int

    init(name: String, amount: Int) {
        self.name = name
        self.amount = amount
    }

}

class Payment {

    let by: String!
    let description: String!
    let amount: String!
    let date: NSDate!

    var participants: [Participant]!

    init(by: String, description: String, amount: String, date: NSDate) {
        self.by = by
        self.description = description
        self.amount = amount
        self.date = date
        self.participants = []
    }

    func addParticipant(name: String, amount: Int) {
        let participant = Participant(name: name, amount: amount)

        participants.append(participant)
    }

}