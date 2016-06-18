//
//  ViewController.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginBoxViewDelegate, UITextFieldDelegate {

    let boxViewHeight: CGFloat = SETTINGS.screenHeight / 2 - 80

    var logoHeaderView: LogoHeaderView!
    var boxView: BoxView!
    var loginBoxView: LoginBoxView!

    override func viewDidLoad() {
        view.backgroundColor = UIColor(colorCode: "F4F4F4")
        navigationItem.title = "Login"

        addLogoHeaderView()
        addLoginBoxView()
        addFooter()
    }

    private func addLogoHeaderView() {
        let yPosition = navigationController?.navigationBar.bounds.maxY

        logoHeaderView = LogoHeaderView(frame: CGRect(x: 0, y: yPosition! - 15, width: SETTINGS.screenWidth, height: SETTINGS.screenHeight / 3))
        logoHeaderView.backgroundColor = UIColor(colorCode: "FFFFFF")

        view.addSubview(logoHeaderView)
    }

    private func addLoginBoxView() {
        boxView = BoxView(frame: CGRect(x: 20, y: logoHeaderView.frame.maxY + 40, width: SETTINGS.screenWidth - 40, height: boxViewHeight))

        loginBoxView = LoginBoxView(frame: CGRect(x: 15, y: 20, width: boxView.frame.width - 30, height: boxView.frame.height - 40))
        loginBoxView.delegate = self
        loginBoxView.emailTextField.textField.delegate = self
        loginBoxView.passwordTextField.textField.delegate = self

        boxView.addSubview(loginBoxView)
        view.addSubview(boxView)
    }

    private func addFooter() {
        let footerMargin: CGFloat = 60
        let footerHeight = SETTINGS.screenHeight - (boxView.frame.maxY) - footerMargin

        let footerImageView = UIImageView(frame: CGRect(x: 0, y: SETTINGS.screenHeight - footerHeight, width: SETTINGS.screenWidth, height: footerHeight))
        footerImageView.image = UIImage(named: "wiebetaaltwat-footer.png")!.imageWithRenderingMode(.AlwaysTemplate)
        footerImageView.tintColor = UIColor(colorCode: "C2C5CA")
        footerImageView.alpha = 0.6
        footerImageView.contentMode = .ScaleAspectFill

        view.addSubview(footerImageView)
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.5) {
            self.logoHeaderView.alpha = 0.0
            self.boxView.center = CGPoint(x: self.boxView.frame.minX + self.boxView.frame.width / 2, y: self.boxView.frame.height)
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == loginBoxView.emailTextField.textField {
            loginBoxView.passwordTextField.textField.becomeFirstResponder()
        } else {
            loginBoxView.endEditing(true)

            UIView.animateWithDuration(0.5) {
                self.logoHeaderView.alpha = 1.0
                self.boxView.center = CGPoint(x: self.boxView.frame.minX + self.boxView.frame.width / 2, y: self.logoHeaderView.frame.maxY + 40 + self.boxView.frame.height / 2)
            }
        }

        return true
    }

    func loginButtonClicked(sender: UIButton!) {
        // TODO: - check if valid email and password values
        loginBoxView.loginButton?.enabled = false

        let email = loginBoxView.emailTextField.textField.text
        let password = loginBoxView.passwordTextField.textField.text
        let user = User(email: email!, password: password!)

        user.login { success in
            self.loginBoxView.loginButton?.enabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

