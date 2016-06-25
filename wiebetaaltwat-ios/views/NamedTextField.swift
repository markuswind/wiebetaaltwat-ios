//
//  TextField.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/23/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class NamedTextField: View {

    var textField: UITextField!
    var name: String!

    var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }

    var errorText: String = "" {
        didSet {
            // TODO::
        }
    }

    init(name: String, placeholder: String, frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.whiteColor()
        layer.borderWidth = 0

        // set variables
        self.name = name
        self.placeholder = placeholder

        // add border
        layer.borderColor = UIColor(colorCode: "DADCD7").CGColor
        layer.borderWidth = 1.0

        addNameAndTextField()
    }

    private func addNameAndTextField() {
        // create namelabel
        let nameLabel = UILabel(frame: CGRect(x: 8, y: 0, width: frame.width * 0.4, height: frame.height))
        nameLabel.text = name

        // create textfield
        textField = UITextField(frame: CGRect(x: nameLabel.frame.maxX, y: 0, width: frame.width - nameLabel.frame.width, height: frame.height))
        textField.placeholder = placeholder
        textField.textColor = UIColor(colorCode: "666666")

        addSubview(nameLabel)
        addSubview(textField)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}