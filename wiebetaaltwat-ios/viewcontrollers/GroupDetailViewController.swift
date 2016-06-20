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
    var payments: [Payment]!

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
        navigationItem.title = group.name
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .Plain, target: nil, action: nil)

        // setup tableview
        tableView.registerClass(GroupTableViewCell.self, forCellReuseIdentifier: "PaymentTableViewCell")
        tableView.rowHeight = 100

        // load payments
        group.getPayments {
            self.payments = self.group.payments
            self.tableView.reloadData()
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = payments {
            return payments.count
        }

        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let payment = payments[indexPath.item]
        let paymentTableViewCell = PaymentTableViewCell(payment: payment, style: .Default, reuseIdentifier: "PaymentTableViewCell")

        return paymentTableViewCell
    }

}