//
//  RegisterViewController.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/25/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, RegisterBoxViewDelegate, UITextFieldDelegate {

    let userScraper = UserScraper()

    var boxView: BoxView!
    var logoHeaderView: LogoHeaderView!
    var registerBoxView: RegisterBoxView!

    var statusLabel: UILabel!
    var statusIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        view.backgroundColor = UIColor(colorCode: "F4F4F4")
        navigationItem.title = "Register"

        // colors only used at register screen
        navigationController?.navigationBar.tintColor = UIColor(colorCode: "FFFFFF")
        navigationController?.navigationBar.barTintColor = UIColor(colorCode: "6d3212")
        navigationController?.navigationBar.barStyle = .Black

        addLogoHeaderView()
        addRegisterBoxView()
        addStatusLabel()
    }

    private func addLogoHeaderView() {
        logoHeaderView = LogoHeaderView(frame: CGRect(x: 0, y: -1, width: SETTINGS.screenWidth, height: SETTINGS.screenHeight / 4 - 49))
        logoHeaderView.backgroundColor = UIColor(colorCode: "FFFFFF")
        logoHeaderView.imageView.image = UIImage(named: "user-register-logo.png")
        logoHeaderView.imageView.contentMode = .ScaleAspectFit

        view.addSubview(logoHeaderView)
    }

    private func addRegisterBoxView() {
        boxView = BoxView(frame: CGRect(x: 20, y: logoHeaderView.frame.maxY + 20, width: view.frame.width - 40, height: view.frame.height * 0.6))

        registerBoxView = RegisterBoxView(frame: CGRect(x: 15, y: 20, width: boxView.frame.width - 30, height: boxView.frame.height - 40))
        registerBoxView.delegate = self
        registerBoxView.emailTextField.textField.delegate = self
        registerBoxView.emailRepeatTextField.textField.delegate = self
        registerBoxView.listNameTextField.textField.delegate = self
        registerBoxView.listDescriptionTextField.textField.delegate = self

        boxView.addSubview(registerBoxView)
        view.addSubview(boxView)
    }

    private func addStatusLabel() {
        statusLabel = UILabel(frame: CGRect(x: 0, y: boxView.frame.maxY + 10, width: view.frame.width, height: 20))
        statusLabel.textAlignment = .Center
        statusLabel.font = UIFont(name: ".SFUIText-Light", size: 12)!
        statusLabel.textColor = UIColor(colorCode: "222222")

        statusIndicatorView = UIActivityIndicatorView(frame: CGRect(x: view.frame.midX - 2, y: statusLabel.frame.maxY + 2, width: 4, height: 4))
        statusIndicatorView.color = UIColor(colorCode: "222222")

        view.addSubview(statusLabel)
        view.addSubview(statusIndicatorView)
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == registerBoxView.emailTextField.textField {
            UIView.animateWithDuration(0.5) {
                self.logoHeaderView.alpha = 0.0
                self.boxView.center = CGPoint(x: self.boxView.frame.minX + self.boxView.frame.width / 2, y: 20 + self.boxView.frame.height / 2)
            }
        } else if textField == registerBoxView.listNameTextField.textField {
            UIView.animateWithDuration(0.5) {
                self.logoHeaderView.alpha = 0.0
                self.boxView.center = CGPoint(x: self.boxView.frame.minX + self.boxView.frame.width / 2, y: -self.registerBoxView.emailRepeatTextField.frame.maxY + self.boxView.frame.height / 2)
            }
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == registerBoxView.emailTextField.textField {
            registerBoxView.emailRepeatTextField.textField.becomeFirstResponder()
        } else if textField == registerBoxView.emailRepeatTextField.textField {
            registerBoxView.listNameTextField.textField.becomeFirstResponder()
        } else if textField == registerBoxView.listNameTextField.textField {
            registerBoxView.listDescriptionTextField.textField.becomeFirstResponder()
        } else if textField == registerBoxView.listDescriptionTextField.textField {
            self.registerBoxView.endEditing(true)

            UIView.animateWithDuration(1.0) {
                self.logoHeaderView.alpha = 1.0
                self.boxView.center = CGPoint(x: self.boxView.frame.minX + self.boxView.frame.width / 2, y: self.logoHeaderView.frame.maxY + 20 + self.boxView.frame.height / 2)
            }
        }

        return true
    }

    func registerButtonClicked(sender: UIButton!) {
        let email = registerBoxView.emailTextField.textField.text ?? ""
        let emailRepeat = registerBoxView.emailRepeatTextField.textField.text ?? ""
        let listName = registerBoxView.listNameTextField.textField.text ?? ""
        let listDescription = registerBoxView.listDescriptionTextField.textField.text ?? ""

        // validate values
        if !email.isValidEmail() || !emailRepeat.isValidEmail() {
            statusLabel.text = "Onjuist e-mailadres ingevuld.."
            statusLabel.textColor = UIColor.redColor()

            return
        }

        if email != emailRepeat {
            statusLabel.text = "e-mailadressen verschillen.."
            statusLabel.textColor = UIColor.redColor()

            return
        }

        if listName == "" {
            statusLabel.text = "Geen lijst naam ingevuld.."
            statusLabel.textColor = UIColor.redColor()

            return
        }

        // register
        statusLabel.text = "Bezig met registreren..."
        statusLabel.textColor = UIColor(colorCode: "222222")
        statusIndicatorView.startAnimating()

        userScraper.register(email, listName: listName, listDescription: listDescription) { success, statusText in
            self.statusIndicatorView.stopAnimating()
            self.statusLabel.text = statusText

            if !success {
                self.statusLabel.textColor = UIColor.redColor()

                // button for password reset
            } else {

            }
        }
    }

}