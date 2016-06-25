//
//  String+Email.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/25/16.
//  Copyright © 2016 Wind. All rights reserved.
//

extension String {

    func isValidEmail() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .CaseInsensitive)

            return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }

}