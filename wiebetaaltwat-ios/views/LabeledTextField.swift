//
//  LabeledTextInput.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 18/06/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class LabeledTextInput: View {

    var textField: UITextField!

    var icon: String!
    var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }

    var errorText: String = "" {
        didSet {
            // TODO - V1.1: show error info icon with error text
        }
    }

    init(icon: String, placeholder: String, frame: CGRect) {
        super.init(frame: frame)

        // set variables
        self.icon = icon
        self.placeholder = placeholder

        // add border
        layer.borderColor = UIColor(colorCode: "DADCD7").CGColor
        layer.borderWidth = 1.0

        addIconAndTextField()
    }

    private func addIconAndTextField() {
        // add icon
        let iconImageView = UIImageView(frame: CGRect(x: frame.height / 4, y: frame.height / 4, width: frame.height / 2, height: frame.height / 2))
        iconImageView.image = UIImage(named: icon)?.imageWithRenderingMode(.AlwaysTemplate)
        iconImageView.tintColor = UIColor(colorCode: "DADCD7")

        // create textfield
        let xPosition = iconImageView.frame.maxX + 8
        let width = frame.width - xPosition - 8

        textField = UITextField(frame: CGRect(x: xPosition, y: iconImageView.frame.minY, width: width, height: iconImageView.frame.height))
        textField.placeholder = placeholder
        textField.textColor = UIColor(colorCode: "666666")

        addSubview(iconImageView)
        addSubview(textField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class EmailLabeledTextInput: LabeledTextInput {

    override init(icon: String, placeholder: String, frame: CGRect) {
        super.init(icon: icon, placeholder: placeholder, frame: frame)

        self.textField.keyboardType = .EmailAddress
        self.textField.autocorrectionType = .No
        self.textField.autocapitalizationType = .None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}