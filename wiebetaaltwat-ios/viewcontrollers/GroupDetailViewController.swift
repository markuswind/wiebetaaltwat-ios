//
//  GroupDetailViewController.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 19/06/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class GroupDetailViewController: UITableViewController {

    let group: Group!

    init(group: Group) {
        self.group = group
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        // setup styling
        tableView.backgroundColor = UIColor(colorCode: "F4F4F4")

        // setup tableview
        tableView.registerClass(GroupTableViewCell.self, forCellReuseIdentifier: "PaymentTableViewCell")
        tableView.rowHeight = 100
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = group.payments {
            return group.payments.count
        }

        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let payment = group.payments[indexPath.item]
        let paymentTableViewCell = PaymentTableViewCell(payment: payment, style: .Default, reuseIdentifier: "PaymentTableViewCell")

        return paymentTableViewCell
    }

    func createButtonClicked(sender: AnyObject) {
        let createPaymentViewController = CreatePaymentViewController(groupid: group.id)
        navigationController?.pushViewController(createPaymentViewController, animated: true)
    }

}