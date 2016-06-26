//
//  GroupMembersViewController.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/22/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class GroupMemberViewController: UITableViewController {

    let group: Group!

    init(group: Group) {
        self.group = group
        super.init(style: .Plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        // setup styling
        tableView.backgroundColor = UIColor(colorCode: "F4F4F4")
        navigationItem.title = group.name
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        // setup tableview
        tableView.registerClass(GroupMemberTableViewCell.self, forCellReuseIdentifier: "groupMemberTableViewCell")
        tableView.rowHeight = 50
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = group.balanceUsers {
            return group.balanceUsers.count
        }

        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let member = group.balanceUsers[indexPath.row]
        let cell = GroupMemberTableViewCell(index: indexPath.row, member: member, style: .Default, reuseIdentifier: "groupMemberTableViewCell")

        return cell
    }

}