//
//  GroupScraper.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/21/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Kanna
import PySwiftyRegex

class GroupScraper: BaseScraper {

    func getGroupOverview(id: String, completion: ([BalanceUser], [Payment]?) -> ()) {
        let parameters: [String: AnyObject] = [
            "lid": id,
            "page": "balance"
        ]

        client.request(.GET, url: base_url, parameters: parameters) { html in
            var payments: [Payment] = []
            var balanceUsers: [BalanceUser] = []

            if let _ = html {
                if let doc = Kanna.HTML(html: html!, encoding: NSUTF8StringEncoding) {
                    // scrape user balance first
                    let userBalanceName = doc.at_xpath("//*[@id=\"user-balance\"]/h3")?.text!
                    var userBalanceAmount = doc.at_xpath("//*[@id=\"user-balance\"]/p/strong")?.text!
                    userBalanceAmount = userBalanceAmount!.replace("€", replacement: "").trim()

                    balanceUsers.append(BalanceUser(name: userBalanceName!, balance: userBalanceAmount!))

                    // scraper other users
                    if let div = doc.at_css("#list-members-balance") {
                        for (_, p) in div.css("p").enumerate() {
                            balanceUsers.append(self.createBalanceUser(p))
                        }
                    }

                    // scrape payments
                    if let table = doc.at_css("#list > tbody") {
                        for (_, tr) in table.css("tr").enumerate() {
                            let columns = tr.css("td")

                            if columns.count > 4 { // sometimes it includes a random row with padding only
                                payments.append(self.createPayment(columns))
                            }
                        }
                    }
                }
            }

            completion(balanceUsers, payments)
        }
    }

    private func createBalanceUser(p: XMLElement) -> BalanceUser {
        let pString = p.toHTML

        let balanceName = re.match(".*\"ellipsis\">(.*)</span>", pString!)?.group(1)
        var balanceAmount = re.match(".*<strong.*\">(.*)</strong>", pString!)?.group(1)
        balanceAmount = balanceAmount!.replace("€", replacement: "").trim()

        return BalanceUser(name: balanceName!, balance: balanceAmount!)
    }

    private func createPayment(columns: XMLNodeSet) -> Payment {
        // get inital values
        let by = columns.at(0)!.text
        let description = columns.at(1)!.text

        let amountMatchObject = re.match(".*€.(.\\d*,\\d*)", columns.at(2)!.toHTML!)
        let amount = amountMatchObject?.group(1)?.trim()

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.dateFromString(columns.at(3)!.text!)

        // create initial payment
        let payment = Payment(by: by!, byid: nil, description: description!, amount: amount!, date: date!)

        // add participants
        let participants = columns.at(4)!.text!.componentsSeparatedByString(",")

        for var participant in participants {
            participant = participant.trim()

            let amountMatchObject = re.match("(.*)\\s(\\d*)x", participant)
            if let _ = amountMatchObject?.group(1) {
                let name = amountMatchObject?.group(1)!
                let amount = Int(amountMatchObject!.group(2)!)

                payment.addParticipant(name!, amount: amount!)
            } else {
                payment.addParticipant(participant, amount: 1)
            }
        }

        // done
        return payment
    }

}