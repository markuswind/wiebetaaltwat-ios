//
//  User.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Foundation

class User: NSCoder {

    var scraper: Scraper!

    // MARK: - variables saved in userdefaults
    let email: String!
    let password: String!

    var groups: [Group]?

    init(email: String, password: String) {
        self.email = email
        self.password = password
        super.init()

        scraper = Scraper(user: self)
    }

    required init(coder aDecoder: NSCoder) {
        email = aDecoder.decodeObjectForKey("email") as! String
        password = aDecoder.decodeObjectForKey("password") as! String
        super.init()

        scraper = Scraper(user: self)
    }

    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        let userdefaults = NSUserDefaults.standardUserDefaults()
        userdefaults.setObject(data, forKey: "user")
        userdefaults.synchronize()
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

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.email, forKey: "email")
        aCoder.encodeObject(self.password, forKey: "password")
    }

}