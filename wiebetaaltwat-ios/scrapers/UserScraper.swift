//
//  LoginScraper.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Kanna
import PySwiftyRegex

class UserScraper: BaseScraper {

    // MARK: - Login scraping
    func login(user: User, completion: (Bool) -> ()) {
        let parameters: [String: AnyObject] = [
            "action": "login",
            "username": user.email,
            "password": user.password
        ]

        client.getLoginSession(base_url, parameters: parameters) { (cookies, html) in
            if let cookies = cookies, html = html {
                if(html.lowercaseString.rangeOfString("uw gebruikersnaam en/of wachtwoord zijn niet correct") != nil) {
                    completion(false)

                    log.warning("login failed with email: \(user.email)")
                } else {
                    for cookie in cookies {
                        if cookie.name == "PHPSESSID" {
                            self.client.manager.session.configuration.HTTPCookieStorage?.setCookie(cookie)
                        }
                    }

                    completion(true)

                    log.verbose("logged in successfully with email: \(user.email)")
                }
            }
        }
    }

    // MARK: - Register scraping
    func register(email: String, listName: String, listDescription: String, completion: (Bool, String) -> ()) {
        let parameters: [String: AnyObject] = [
            "action": "register",
            "email" : email,
            "email2": email,
            "list_name": listName,
            "list_description": listDescription
        ]

        client.request(.POST, url: base_url + "/register/", parameters: parameters) { html in
            log.debug(html)

            if let _ = html {
                if(html?.lowercaseString.rangeOfString("er is al een gebruiker met") != nil) {
                    completion(false, "E-mailadres al gebruikt, wachtwoord vergeten?")

                    log.info("registering failed with email: \(email) - already used")
                } else if(html?.lowercaseString.rangeOfString("We hebben een activatie-link\ngestuurd naar:") != nil) {
                    completion(true, "Succesvol geregistreerd, bevestig uw ontvangen email")

                    log.verbose("registered successfully with email: \(email)")
                } else {
                    completion(false, "Registreren mislukt, onbekend probleem")

                    log.warning("registering failed with email: \(email) - unkown issue")
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

}