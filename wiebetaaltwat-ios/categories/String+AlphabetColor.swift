//
//  String+AlphabetColor.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/23/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Foundation

extension String {

    func alphaBetColor() -> UIColor {
        let alphabetColors = [0x5A8770, 0xB2B7BB, 0x6FA9AB, 0xF5AF29, 0x0088B9, 0xF18636, 0xD93A37, 0xA6B12E, 0x5C9BBC, 0xF5888D, 0x9A89B5, 0x407887, 0x9A89B5, 0x5A8770, 0xD33F33, 0xA2B01F, 0xF0B126, 0x0087BF, 0xF18636, 0x0087BF, 0xB2B7BB, 0x72ACAE, 0x9C8AB4, 0x5A8770, 0xEEB424, 0x407887]

        let character = String(self[self.startIndex])
        let str = String(character).unicodeScalars
        let unicode = Int(str[str.startIndex].value)

        if 65...90 ~= unicode {
            let hex = alphabetColors[unicode - 65]

            return UIColor(red: CGFloat(Double((hex >> 16) & 0xFF)) / 255.0, green: CGFloat(Double((hex >> 8) & 0xFF)) / 255.0, blue: CGFloat(Double((hex >> 0) & 0xFF)) / 255.0, alpha: 1.0)
        }

        return UIColor.orangeColor()
    }

}