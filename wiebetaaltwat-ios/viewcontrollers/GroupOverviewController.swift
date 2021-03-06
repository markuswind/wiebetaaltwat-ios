//
//  GroupOverviewController.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class GroupOverViewController: UITableViewController {

    var shouldRefreshSession: Bool = true
    var user: User!
    var groups: [Group]!

    override func viewDidLoad() {
        // setup styling
        tableView.backgroundColor = UIColor(colorCode: "F4F4F4")
//        tableView.separatorColor = UIColor.clearColor()

        navigationItem.title = "List Overview"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        // setup tableview
        tableView.registerClass(GroupTableViewCell.self, forCellReuseIdentifier: "GroupTableViewCell")
        tableView.rowHeight = 140

        // load groups
        user.getGroups({
            self.groups = self.user.groups
            self.tableView.reloadData()
        })
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = groups {
            return groups.count
        }

        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let group = groups[indexPath.item]
        let groupTableViewCell = GroupTableViewCell(group: group, style: .Default, reuseIdentifier: "GroupTableViewCell")

        return groupTableViewCell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let group = groups[indexPath.item]
        let groupSegmentedViewController = GroupSegmentedViewController(group: group)

        navigationController?.pushViewController(groupSegmentedViewController, animated: true)
    }

}