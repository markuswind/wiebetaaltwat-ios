//
//  CreateCardView.swift
//  wiebetaalwat-ios
//
//  Created by Markus Wind on 18/06/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class LoginBoxView: View {


    let loginButtonMargin: CGFloat = 8.0
    var inputFieldHeight: CGFloat!

    var delegate: LoginBoxViewDelegate!
    var emailTextField: LabeledTextInput!
    var passwordTextField: LabeledTextInput!
    var loginButton: UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)

        inputFieldHeight = frame.height / 3 - (loginButtonMargin / 2)

        createInputs()
        createLoginButton()
    }
    
    private func createInputs() {
        let emailTextFieldFrame = CGRect(x: 0, y: 0, width: frame.width, height: inputFieldHeight)
        emailTextField = LabeledTextInput(icon: "account.png", placeholder: "Email", frame: emailTextFieldFrame)
        emailTextField.textField.keyboardType = .EmailAddress
        emailTextField.textField.autocorrectionType = .No
        emailTextField.textField.returnKeyType = .Next

        let passwordTextFieldFrame = CGRect(x: 0, y: emailTextFieldFrame.maxY - 1, width: frame.width, height: inputFieldHeight)
        passwordTextField = LabeledTextInput(icon: "lock.png", placeholder: "Password", frame: passwordTextFieldFrame)
        passwordTextField.textField.secureTextEntry = true
        passwordTextField.textField.returnKeyType = .Done

        addSubview(emailTextField)
        addSubview(passwordTextField)
    }

    private func createLoginButton() {
        let loginButtonHeight = inputFieldHeight * 0.75

        loginButton = UIButton(frame: CGRect(x: 0, y: frame.maxY - loginButtonHeight - 20, width: frame.width, height: loginButtonHeight))
        loginButton!.layer.cornerRadius = 1.0
        loginButton!.backgroundColor = UIColor(colorCode: "FF8000")

        loginButton!.titleLabel!.font = UIFont(name: "HelveticaNeue", size: loginButtonHeight * 0.4)
        loginButton!.setTitle("Login", forState: .Normal)
        loginButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton!.addTarget(self, action: #selector(self.loginButtonClicked(_:)), forControlEvents: .TouchUpInside)

        addSubview(loginButton!)
    }

    func loginButtonClicked(sender: UIButton) {
        loginButton?.enabled = false

        // call delegate
        delegate.loginButtonClicked(sender)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

protocol LoginBoxViewDelegate: class {

    func loginButtonClicked(sender: UIButton!)

}