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

class Scraper {

    let user: User!
    let base_url = "https://www.wiebetaaltwat.nl"
    let client = Client()
    let manager = Manager()

    init(user: User) {
        self.user = user
    }

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
                        self.manager.session.configuration.HTTPCookieStorage?.setCookie(cookie)
                    }

                    completion(true)

                    log.verbose("logged in successfully with email: \(self.user.email)")
                }
            }
        }
    }

}