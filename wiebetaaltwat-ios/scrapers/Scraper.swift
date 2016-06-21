//
//  LoginScraper.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Alamofire
import Kanna
import PySwiftyRegex

class Scraper: NSObject {

    var user: User!
    let base_url = "https://www.wiebetaaltwat.nl"
    let client = Client.sharedClient

    // MARK: - Login scraping
    func login(completion: (Bool) -> ()) {
        let parameters: [String: AnyObject] = [
            "action": "login",
            "username": user.email,
            "password": user.password
        ]

        client.getLoginSession(base_url, parameters: parameters) { (cookies, html) in
            if let cookies = cookies, html = html {
                if(html.lowercaseString.rangeOfString("uw gebruikersnaam en/of wachtwoord zijn niet correct") != nil) {
                    completion(false)

                    log.warning("login failed with email: \(self.user.email)")
                } else {
                    for cookie in cookies {
                        if cookie.name == "PHPSESSID" {
                            self.client.manager.session.configuration.HTTPCookieStorage?.setCookie(cookie)
                        }
                    }

                    completion(true)

                    log.verbose("logged in successfully with email: \(self.user.email)")
                }
            }
        }
    }

    // MARK: - Group scraping
    func getGroups(completion: [Group]? -> ()) {
        let parameters: [String: AnyObject] = [:]

        client.request(.GET, url: base_url, parameters: parameters) { html in
            var groups: [Group] = []

            if let _ = html {
                if let doc = Kanna.HTML(html: html!, encoding: NSUTF8StringEncoding) {
                    if let table = doc.at_css("#content-view > table > tbody") {
                        for (_, tr) in table.css("tr").enumerate() {
                            let columns = tr.css("td")
                            let group = self.createGroup(columns)

                            groups.append(group)
                        }
                    }
                }
            }

            completion(groups)

            // TODO: - delete log for testing purposes
            if groups.count > 0 {
                log.verbose("successfully scraped groups (count: \(groups.count))")
            } else {
                log.warning("scraping groups failed")
            }
        }
    }

    private func createGroup(columns: XMLNodeSet) -> Group {
        let idtext = columns.at(0)?.toHTML

        // create inital group
        let id = re.match(".*lid=(\\d*)&", idtext!)!.group(1)
        let name = columns.at(0)?.text
        let group = Group(id: id!, name: name!)

        // strip balance values
        let ownBalance = re.match(".*€.(.\\d*,\\d*)", columns.at(1)!.toHTML!)!.group(1)

        let highestBalanceMatchObject = re.match("<td>(.*).<.*€(.\\d*,\\d*)", columns.at(2)!.toHTML!)
        let highestBalance = highestBalanceMatchObject?.group(2)?.trim()
        let highestBalanceUser = highestBalanceMatchObject?.group(1)

        let lowestBalanceMatchObject = re.match("<td>(.*).<.*€.(.\\d*,\\d*)", columns.at(3)!.toHTML!)
        let lowestBalance = lowestBalanceMatchObject?.group(2)?.trim()
        let lowestBalanceUser = lowestBalanceMatchObject?.group(1)

        // set values
        group.ownBalance = ownBalance
        group.highestBalance = highestBalance
        group.highestBalanceUser = highestBalanceUser
        group.lowestBalance = lowestBalance
        group.lowestBalanceUser = lowestBalanceUser

        // done
        return group
    }

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


    // MARK - Payment scraping
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