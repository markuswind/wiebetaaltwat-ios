//
//  Group.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

class Group {

    let groupScraper = GroupScraper()
    let id: String!
    let name: String!

    var ownBalance: String!
    var highestBalance: String!
    var highestBalanceUser: String!
    var lowestBalance: String!
    var lowestBalanceUser: String!

    var payments: [Payment]!

    init(id: String, name: String) {
        self.id = id
        self.name = name
        self.payments = []
    }

    func getPayments(completion: () ->()) {
        groupScraper.getGroupPayments(id) { payments in
            self.payments = []
            self.payments = payments

            completion()
        }
    }

}