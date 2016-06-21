//
//  GroupScraper.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/21/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Kanna
import PySwiftyRegex

class GroupScraper: Scraper {

    func getGroupPayments(id: String, completion: [Payment]? -> ()) {
        let parameters: [String: AnyObject] = [
            "lid": id,
            "page": "balance"
        ]

        client.request(.GET, url: base_url, parameters: parameters) { html in
            var payments: [Payment] = []

            if let _ = html {
                if let doc = Kanna.HTML(html: html!, encoding: NSUTF8StringEncoding) {
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

            completion(payments)
        }
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