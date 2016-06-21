//
//  CreatePaymentViewController.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/20/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class CreatePaymentViewController: UIViewController {

    let scraper = Scraper()
    let groupid: String!
    var participants: [Participant]!

    var inputBoxView: BoxView!
    var amountInputLabel: LabeledTextInput!

    init(groupid: String!) {
        self.groupid = groupid
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = UIColor(colorCode: "F4F4F4")
        navigationItem.title = "Add entry"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: nil, action: nil)

        scraper.getInitialPaymentValues(groupid) { participants in
            self.participants = participants

            // TODO: - create the input labels here?
        }

        createInputLabels()
    }

    private func createInputLabels() {
        inputBoxView = BoxView(frame: CGRect(x: 8, y: view.frame.height / 3, width: view.frame.width - 16, height: view.frame.height / 2))
        inputBoxView.backgroundColor = UIColor.whiteColor()

        amountInputLabel = LabeledTextInput(icon: "account.png", placeholder: "0,00", frame: CGRect(x: 8, y: 8, width: inputBoxView.frame.width - 16, height: 40))


        inputBoxView.addSubview(amountInputLabel)
        view.addSubview(inputBoxView)
    }

}