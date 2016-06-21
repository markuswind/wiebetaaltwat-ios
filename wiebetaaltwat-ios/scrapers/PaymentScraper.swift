//
//  PaymentScraper.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/21/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Kanna
import PySwiftyRegex

class PaymentScraper: BaseScraper {

    func getInitialPaymentValues(groupid: String, completion: ([Participant]) -> ()) {
        let parameters = [
            "lid": groupid,
            "page": "transaction",
            "type": "add"
        ]

        client.request(.GET, url: base_url, parameters: parameters) { html in
            var participants: [Participant] = []

            if let _ = html {
                if let doc = Kanna.HTML(html: html!, encoding: NSUTF8StringEncoding) {
                    if let select = doc.at_css("#payment_by") {
                        for (_, option) in select.css("option").enumerate() {
                            let optionHtml = option.toHTML
                            let matchObject = re.match(".*value=\"(\\d*)\">(.*)<", optionHtml!)

                            let id = matchObject?.group(1)
                            let name = matchObject?.group(2)

                            participants.append(Participant(id: id!, name: name!, amount: 0))
                        }
                    }
                }
            }

            completion(participants)
        }
    }

    func createNewPaymentEntry(groupid: String, payment: Payment) {

    }

}