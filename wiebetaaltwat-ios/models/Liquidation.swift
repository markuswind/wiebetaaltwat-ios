//
//  Liquidation.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/22/16.
//  Copyright © 2016 Wind. All rights reserved.
//

class LiquidationUser {

    let name: String!
    let bankAccount: String!
    let balance: String!

    init(name: String, bankAccount: String, balance: String) {
        self.name = name
        self.bankAccount = bankAccount
        self.balance = balance
    }

}

enum LiquidationType {
    case Pay
    case Receive
}

class LiquidationPayment {

    let type: LiquidationType!
    let name: String!
    let amount: String!

    init(type: LiquidationType, name: String, amount: String) {
        self.type = type
        self.name = name
        self.amount = amount
    }

}

class Liquidation {

    let liquidationUser: LiquidationUser!
    let liquidationPayments: [LiquidationPayment]!

    init(user: LiquidationUser, payment: [LiquidationPayment]) {
        self.liquidationUser = user
        self.liquidationPayments = payment
    }

}