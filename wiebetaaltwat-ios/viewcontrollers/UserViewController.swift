//
//  UserViewController.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/23/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    var user: User!

    var avatarBoxView: BoxView!
    var avatarImageView: UIImageView!
    var nameLabel: UILabel!
    var currentBalanceLabel: UILabel!

    override func viewDidLoad() {
        view.backgroundColor = UIColor(colorCode: "F4F4F4")
        navigationItem.title = "Profile"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        createAvatarBoxViewAndProfileImage()
        createCurrentBalanceViews()
        createInputFields()
    }

    private func createAvatarBoxViewAndProfileImage() {
        avatarBoxView = BoxView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2.75))
        avatarBoxView.backgroundColor = UIColor.whiteColor()

        let avaterSize = view.frame.height / 6
        avatarImageView = UIImageView(frame: CGRect(x: view.frame.midX - avaterSize / 2, y: 25, width: avaterSize, height: avaterSize))
        avatarImageView.setImageWithString("Markus Wind", color: "Markus Wind".alphaBetColor(), circular: true)

        nameLabel = UILabel(frame: CGRect(x: 0, y: avatarImageView.frame.maxY + 12, width: view.frame.width, height: 20))
        nameLabel.font = UIFont(name: ".SFUIText-Medium", size: 16)!
        nameLabel.text = "Markus Wind"
        nameLabel.textAlignment = .Center

        avatarBoxView.addSubview(avatarImageView)
        avatarBoxView.addSubview(nameLabel)

        view.addSubview(avatarBoxView)
    }

    private func createCurrentBalanceViews() {
        let balanceInfoLabel = UILabel(frame: CGRect(x: 0, y: nameLabel.frame.maxY + 8, width: view.frame.width, height: 10))
        balanceInfoLabel.font = UIFont(name: ".SFUIText-Light", size: 10)!
        balanceInfoLabel.text = "Huidige balans:"
        balanceInfoLabel.textAlignment = .Center

        currentBalanceLabel = UILabel(frame: CGRect(x: 0, y: balanceInfoLabel.frame.maxY + 8, width: view.frame.width, height: 15))
        currentBalanceLabel.font = UIFont(name: ".SFUIText-Medium", size: 15)!
        currentBalanceLabel.text = "€ 100,00"
        currentBalanceLabel.textColor = UIColor(colorCode: "26A65B")
        currentBalanceLabel.textAlignment = .Center

        avatarBoxView.addSubview(balanceInfoLabel)
        avatarBoxView.addSubview(currentBalanceLabel)
    }

    private func createInputFields() {
        let tabBarHeight = tabBarController?.tabBar.frame.size.height
        let inputHeight: CGFloat = (view.frame.height - tabBarHeight! - avatarBoxView.frame.maxY - 14 - 69) / 6

        let inputInfoLabel = UILabel(frame: CGRect(x: 8, y: avatarBoxView.frame.maxY + 10, width: view.frame.width, height: inputHeight))
        inputInfoLabel.text = "PROFIEL"
        inputInfoLabel.font = UIFont(name: ".SFUIText-Light", size: 15)
        inputInfoLabel.textColor = UIColor(colorCode: "222222")

        let bankAccountTextField = NamedTextField(name: "Rekening", placeholder: "NLAAAA0000000", frame: CGRect(x: -1, y: inputInfoLabel.frame.maxY + 4, width: view.frame.width + 1, height: inputHeight))

        let bankAccountNameTextField = NamedTextField(name: "T.N.V.", placeholder: "Mk. Wind", frame: CGRect(x: -1, y: bankAccountTextField.frame.maxY - 1, width: view.frame.width + 1, height: inputHeight))

        let cityTextField = NamedTextField(name: "Woonplaats", placeholder: "Groningen", frame: CGRect(x: -1, y: bankAccountNameTextField.frame.maxY - 1, width: view.frame.width + 1, height: inputHeight))

        let genderTextField = NamedTextField(name: "Geslacht", placeholder: "Man", frame: CGRect(x: -1, y: cityTextField.frame.maxY - 1, width: view.frame.width + 1, height: inputHeight))

        let birthdateTextField = NamedTextField(name: "Geboortedatum", placeholder: "09-11-1991", frame: CGRect(x: -1, y: genderTextField.frame.maxY - 1, width: view.frame.width + 1, height: inputHeight))

        view.addSubview(inputInfoLabel)
        view.addSubview(bankAccountTextField)
        view.addSubview(bankAccountNameTextField)
        view.addSubview(cityTextField)
        view.addSubview(genderTextField)
        view.addSubview(birthdateTextField)
    }

}