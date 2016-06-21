//
//  Payment.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/19/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Foundation

class Participant {

    let id: String? // id's are only used when adding new entry
    let name: String
    let amount: Int

    init(id: String?, name: String, amount: Int) {
        self.id = id
        self.name = name
        self.amount = amount
    }

}

class Payment {

    let by: String!
    let byid: String?
    let description: String!
    let amount: String!
    let date: NSDate!

    var participants: [Participant]!

    init(by: String, byid: String?, description: String, amount: String, date: NSDate) {
        self.by = by
        self.byid = byid
        self.description = description
        self.amount = amount
        self.date = date
        self.participants = []
    }

    func addParticipant(name: String, amount: Int) {
        let participant = Participant(id: nil, name: name, amount: amount)

        participants.append(participant)
    }

}