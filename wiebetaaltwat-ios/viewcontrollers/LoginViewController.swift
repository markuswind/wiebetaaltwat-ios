//
//  ViewController.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginBoxViewDelegate, UITextFieldDelegate {

    var user: User?
    let boxViewHeight: CGFloat = SETTINGS.screenHeight / 2 - 80

    var logoHeaderView: LogoHeaderView!
    var boxView: BoxView!
    var loginBoxView: LoginBoxView!

    var statusLabel: UILabel!
    var statusIndicatorView: UIActivityIndicatorView!

    var registerButton: UIButton!

    init(user: User?) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = UIColor(colorCode: "F4F4F4")
        navigationItem.title = "Login"

        // colors only used at login screen
        navigationController?.navigationBar.tintColor = UIColor(colorCode: "FFFFFF")
        navigationController?.navigationBar.barTintColor = UIColor(colorCode: "6d3212")
        navigationController?.navigationBar.barStyle = .Black

        addLogoHeaderView()
        addLoginBoxView()
        addStatusLabel()
//        addFooter()
        addRegisterButton()

        // retrieved user in delegate?
        if let _ = user {
            login()
        }
    }

    private func addLogoHeaderView() {
        logoHeaderView = LogoHeaderView(frame: CGRect(x: 0, y: -1, width: SETTINGS.screenWidth, height: SETTINGS.screenHeight / 3 - 49))
        logoHeaderView.backgroundColor = UIColor(colorCode: "FFFFFF")
        logoHeaderView.imageView.image = UIImage(named: "user-login-logo.png")
        logoHeaderView.imageView.contentMode = .ScaleAspectFit

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

    private func addStatusLabel() {
        statusLabel = UILabel(frame: CGRect(x: 0, y: boxView.frame.maxY + 10, width: view.frame.width, height: 20))
        statusLabel.textAlignment = .Center
        statusLabel.font = UIFont(name: ".SFUIText-Light", size: 12)!
        statusLabel.textColor = UIColor(colorCode: "222222")

        statusIndicatorView = UIActivityIndicatorView(frame: CGRect(x: view.frame.midX - 15, y: statusLabel.frame.maxY + 4, width: 30, height: 30))
        statusIndicatorView.color = UIColor(colorCode: "222222")

        view.addSubview(statusLabel)
        view.addSubview(statusIndicatorView)
    }

    private func addRegisterButton() {
        let registerButtonHeight = view.frame.maxY - statusIndicatorView.frame.maxY - 8
        registerButton = UIButton(frame: CGRect(x: 0, y: view.frame.maxY - registerButtonHeight, width: view.frame.width, height: registerButtonHeight / 2))

        registerButton.backgroundColor = UIColor(colorCode: "0098db")
        registerButton.titleLabel?.sizeToFit()

        registerButton.setTitle("Registreer nieuw account", forState: .Normal)
        registerButton.titleLabel!.font = UIFont(name: ".SFUIText-Light", size: 13)

        registerButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerButton.addTarget(self, action: #selector(self.registerButtonClicked(_:)), forControlEvents: .TouchUpInside)

        view.addSubview(registerButton)
    }

    private func addFooter() {
        let footerMargin: CGFloat = 20
        let footerHeight = SETTINGS.screenHeight - (boxView.frame.maxY) - footerMargin

        let footerImageView = UIImageView(frame: CGRect(x: 0, y: SETTINGS.screenHeight - footerHeight, width: SETTINGS.screenWidth, height: footerHeight))
        footerImageView.image = UIImage(named: "wiebetaaltwat-footer.png")!.imageWithRenderingMode(.AlwaysTemplate)
        footerImageView.tintColor = UIColor(colorCode: "C2C5CA")
        footerImageView.alpha = 0.6
        footerImageView.contentMode = .ScaleAspectFit

        view.insertSubview(footerImageView, belowSubview: statusLabel)
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.5) {
            self.logoHeaderView.alpha = 0.0
            self.boxView.center = CGPoint(x: self.boxView.frame.minX + self.boxView.frame.width / 2, y: 20 + self.boxView.frame.height / 2)
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == loginBoxView.emailTextField.textField {
            loginBoxView.passwordTextField.textField.becomeFirstResponder()
        } else {
            loginBoxView.endEditing(true)

            statusLabel.text = ""
            statusLabel.textColor = UIColor(colorCode: "222222")

            UIView.animateWithDuration(1.0) {
                self.logoHeaderView.alpha = 1.0
                self.boxView.center = CGPoint(x: self.boxView.frame.minX + self.boxView.frame.width / 2, y: self.logoHeaderView.frame.maxY + 40 + self.boxView.frame.height / 2)
            }
        }

        return true
    }

    func loginButtonClicked(sender: UIButton!) {
        textFieldShouldReturn(loginBoxView.passwordTextField.textField)

        let email = loginBoxView.emailTextField.textField.text
        let password = loginBoxView.passwordTextField.textField.text

        if !email!.isValidEmail() {
            statusLabel.text = "Uw emailadres is ongeldig.."
            statusLabel.textColor = UIColor.redColor()
        } else if password == "" {
            statusLabel.text = "Vul uw wachtwoord in.."
            statusLabel.textColor = UIColor.orangeColor()
        } else {
            self.user = User(email: email!, password: password!)
            self.login()
        }
    }

    func login() {
        loginBoxView.loginButton?.enabled = false

        statusLabel.text = "Aan het inloggen..."
        statusIndicatorView.startAnimating()

        user!.login { success in
            if success {
                self.statusIndicatorView.stopAnimating()

                self.user!.save()
                self.loginSucceeded()
            } else {
                self.statusLabel.text = "Email en/of wachtwoord is incorrect"
                self.statusLabel.textColor = UIColor.redColor()
                self.statusIndicatorView.stopAnimating()

                self.loginBoxView.loginButton?.enabled = true
            }
        }
    }

    private func loginSucceeded() {
        let tabBarController = TabBarController()

        if let navigationController = tabBarController.viewControllers![0] as? NavigationController {
            if let groupOverViewController = navigationController.viewControllers[0] as? GroupOverViewController {
                groupOverViewController.user = self.user!
            }
        }

        if let navigationController = tabBarController.viewControllers![1] as? NavigationController {
            if let userViewController = navigationController.viewControllers[0] as? UserViewController {
                userViewController.user = self.user!
            }
        }

        presentViewController(tabBarController, animated: true, completion: nil)
    }

    func registerButtonClicked(sender: UIButton!) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}