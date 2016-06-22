//
//  LiquidationScraper.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/22/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Kanna
import PySwiftyRegex

class LiquidationScraper: BaseScraper {

    func getLiquidations(id: String, completion: ([Liquidation]!) -> ()) {
        let parameters: [String: AnyObject] = [
            "lid": id,
            "page": "liquidate"
        ]

        client.request(.GET, url: base_url, parameters: parameters) { html in
            var liquidations: [Liquidation] = []

            if let _ = html {
                if let doc = Kanna.HTML(html: html!, encoding: NSUTF8StringEncoding) {
                    if let table = doc.at_xpath("//*[@id=\"content-view\"]/div[1]/table/tbody") {
                        for(_, tr) in table.css("tr").enumerate() {
                            let liquidationUser = self.createLiquidationUser(tr)
                            let liquidationPayments = self.createLiquidationPayments(tr)

                            liquidations.append(Liquidation(user: liquidationUser, payment: liquidationPayments))
                        }
                    }
                }
            }

            completion(liquidations)
        }
    }

    private func createLiquidationUser(tr: XMLElement) -> LiquidationUser {
        // create a string first
        var html = tr.toHTML!
        html = html.replace("\t", replacement: "")
        html = html.replace("\n", replacement: "")

        // regex values
        let matchObject = re.match(".*\">(.*)<br>(.*)<strong.*\">€(.*)<\\/strong>", html)
        let name = matchObject?.group(1)
        let bankAccount = matchObject?.group(2)
        let balance = matchObject?.group(3)?.trim()

        // done
        return LiquidationUser(name: name!, bankAccount: bankAccount!, balance: balance!)
    }

    private func createLiquidationPayments(tr: XMLElement) -> [LiquidationPayment] {
        var liquidationPayments: [LiquidationPayment] = []

        for (_, li) in tr.css("li").enumerate() {
            let html = li.toHTML!

            // regex type
            let typeString = re.match(".*<li class=\\\"liquidate-(.*)\\\">\\n<span", html)!.group(1)
            let type: LiquidationType = (typeString == "pay") ? .Pay : .Receive

            // regex name
            let name = re.match(".*\\s*.*member\">(.*)<", html)!.group(1)

            // regex amount
            var amount = re.match(".*\\s*.*>€(.*)<\\/span>\\ste", html)!.group(1)
            amount = amount?.trim()

            // done
            liquidationPayments.append(LiquidationPayment(type: type, name: name!, amount: amount!))
        }

        return liquidationPayments
    }

}