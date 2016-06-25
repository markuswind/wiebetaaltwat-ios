//
//  RegisterBoxView.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/25/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class RegisterBoxView: View {

    let registerButtonMargin: CGFloat = 8.0
    let infoLabelMargin: CGFloat = 4.0
    var inputFieldHeight: CGFloat!

    var delegate: RegisterBoxViewDelegate!

    var accountInfoLabel: UILabel!
    var emailTextField: LabeledTextInput!
    var emailRepeatTextField: LabeledTextInput!

    var listInfoLabel: UILabel!
    var listNameTextField: LabeledTextInput!
    var listDescriptionTextField: LabeledTextInput!

    var registerButton: UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)

        inputFieldHeight = frame.height / 6 - (registerButtonMargin / 2)

        createInputs()
        createRegisterButton()
    }

    private func createInputs() {
        accountInfoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: inputFieldHeight / 2))
        accountInfoLabel.text = "Account gegevens"
        accountInfoLabel.font = UIFont(name: ".SFUIText-Medium", size: 13.0)
        accountInfoLabel.textColor = UIColor(colorCode: "222222")

        let emailTextFieldFrame = CGRect(x: 0, y: accountInfoLabel.frame.maxY + infoLabelMargin, width: frame.width, height: inputFieldHeight)
        emailTextField = EmailLabeledTextInput(icon: "account.png", placeholder: "Email", frame: emailTextFieldFrame)
        emailTextField.textField.returnKeyType = .Next

        let emailRepeatTextFieldFrame = CGRect(x: 0, y: emailTextFieldFrame.maxY - 1, width: frame.width, height: inputFieldHeight)
        emailRepeatTextField = EmailLabeledTextInput(icon: "account.png", placeholder: "Email (nogmaals)", frame: emailRepeatTextFieldFrame)
        emailRepeatTextField.textField.returnKeyType = .Next

        listInfoLabel = UILabel(frame: CGRect(x: 0, y: emailRepeatTextFieldFrame.maxY + infoLabelMargin * 2, width: frame.width, height: inputFieldHeight / 2))
        listInfoLabel.text = "Lijst gegevens"
        listInfoLabel.font = UIFont(name: ".SFUIText-Medium", size: 13.0)
        listInfoLabel.textColor = UIColor(colorCode: "222222")

        let listNameTextFieldFrame = CGRect(x: 0, y: listInfoLabel.frame.maxY + infoLabelMargin, width: frame.width, height: inputFieldHeight)
        listNameTextField = LabeledTextInput(icon: "account.png", placeholder: "Naam", frame: listNameTextFieldFrame)
        listNameTextField.textField.keyboardType = .Default
        listNameTextField.textField.returnKeyType = .Next

        let listDescriptionTextFieldFrame = CGRect(x: 0, y: listNameTextFieldFrame.maxY - 1, width: frame.width, height: inputFieldHeight)
        listDescriptionTextField = LabeledTextInput(icon: "account.png", placeholder: "Naam", frame: listDescriptionTextFieldFrame)
        listDescriptionTextField.textField.returnKeyType = .Done

        addSubview(accountInfoLabel)
        addSubview(emailTextField)
        addSubview(emailRepeatTextField)
        addSubview(listInfoLabel)
        addSubview(listNameTextField)
        addSubview(listDescriptionTextField)
    }

    // TODO?: - create abstract submitbutton
    private func createRegisterButton() {
        let registerButtonHeight = inputFieldHeight * 0.75

        registerButton = UIButton(frame: CGRect(x: 0, y: frame.maxY - registerButtonHeight - 20, width: frame.width, height: registerButtonHeight))
        registerButton!.layer.cornerRadius = 1.0
        registerButton!.backgroundColor = UIColor(colorCode: "FF7900")

        registerButton!.titleLabel!.font = UIFont(name: "HelveticaNeue", size: registerButtonHeight * 0.4)
        registerButton!.setTitle("Register", forState: .Normal)
        registerButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerButton!.addTarget(self, action: #selector(self.registerButtonClicked(_:)), forControlEvents: .TouchUpInside)

        addSubview(registerButton!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func registerButtonClicked(sender: UIButton) {
        delegate.registerButtonClicked(sender)
    }

}

protocol RegisterBoxViewDelegate: class {

    func registerButtonClicked(sender: UIButton!)

}