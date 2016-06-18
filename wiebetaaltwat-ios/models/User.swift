//
//  User.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

class User {

    var scraper: Scraper!

    // MARK: - variables saved in userdefaults
    let email: String!
    let password: String!

    var groups: [Group]?

    init(email: String, password: String) {
        self.email = email
        self.password = password

        scraper = Scraper(user: self)
    }

    func login(completion: (Bool) -> ()) {
        scraper.login({ success in
            completion(success)
        })
    }

    func getGroups(completion: () -> ()) {
        scraper.getGroups { groups in
            self.groups = groups
        }
    }

}