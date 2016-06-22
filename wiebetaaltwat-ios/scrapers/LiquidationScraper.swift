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
                            print(tr.text)
                        }
                    }
                }
            }

            completion(liquidations)
        }
    }

}