//
//  Group.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

class BalanceUser {

    let name: String!
    let balance: String!

    init(name: String, balance: String) {
        self.name = name
        self.balance = balance
    }

}

class Group {

    let groupScraper = GroupScraper()
    let liquidationScraper = LiquidationScraper()
    let id: String!
    let name: String!

    var ownBalance: String!
    var highestBalance: String!
    var highestBalanceUser: String!
    var lowestBalance: String!
    var lowestBalanceUser: String!

    var payments: [Payment]!
    var balanceUsers: [BalanceUser]!
    var liquidations: [Liquidation]!

    init(id: String, name: String) {
        self.id = id
        self.name = name
        self.payments = []
        self.balanceUsers = []
        self.liquidations = []
    }

    func scrapeAllGroupData(completion: () -> ()) {
        groupScraper.getGroupOverview(id) { balanceUsers, payments in
            self.balanceUsers = []
            self.balanceUsers = balanceUsers
            
            self.payments = []
            self.payments = payments

            // and we also scrape the liquidations
            self.liquidationScraper.getLiquidations(self.id) { liquidations in
                self.liquidations = []
                self.liquidations = liquidations

                completion()
            }
        }
    }

}