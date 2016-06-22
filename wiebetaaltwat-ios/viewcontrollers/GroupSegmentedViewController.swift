//
//  GroupSegmentedViewController.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/22/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

class GroupSegmentedViewController: UIViewController {

    let group: Group!

    var currentViewController: UIViewController!
    var segmentedControl: UISegmentedControl!
    var containerView: UIView!

    init(group: Group) {
        self.group = group
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = UIColor(colorCode: "F4F4F4")
        navigationItem.title = group.name
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        setupSegmentedControlAndContainerView()

        // setup inital viewcontroller
        let initialViewController = viewControllerForSegmentedIndex(0)
        initialViewController.view.frame = containerView.bounds

        containerView.addSubview(initialViewController.view)
        currentViewController = initialViewController

        addChildViewController(initialViewController)
        setupRightBarButtonItemForSegmentedIndex(0)

        // load all group data
        group.scrapeAllGroupData {
            if let currentViewController = self.currentViewController as? UITableViewController {
                currentViewController.tableView.reloadData()
            }
        }
    }

    private func setupSegmentedControlAndContainerView() {
        // setup segmentedcontrol
        let segmentedBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: SETTINGS.screenWidth, height: 50))
        segmentedBackgroundView.backgroundColor = UIColor(colorCode: "FF8000")

        segmentedControl = UISegmentedControl(items: ["Overzicht", "Deelnemers", "Afrekenen"])
        segmentedControl.frame = CGRect(x: 15, y: 5, width: SETTINGS.screenWidth - 30, height: 30)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(GroupSegmentedViewController.segmentChanged(_:)), forControlEvents: .ValueChanged)
        segmentedControl.tintColor = UIColor(colorCode: "E86E0F")

        let titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, forState: .Selected)
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, forState: .Normal)

        // setup containerview
        let containerHeight = view.frame.height - 20 - (tabBarController?.tabBar.frame.height)! - ((navigationController?.navigationBar.frame.height)! + segmentedBackgroundView.frame.height)
        containerView = UIView(frame: CGRect(x: 0, y: segmentedBackgroundView.frame.maxY, width: SETTINGS.screenWidth, height: containerHeight))

        // done
        view.addSubview(segmentedBackgroundView)
        view.addSubview(segmentedControl)
        view.addSubview(containerView)
    }

    func segmentChanged(sender: UISegmentedControl) {
        let viewController = viewControllerForSegmentedIndex(sender.selectedSegmentIndex)
        viewController.view.frame = containerView.bounds
        viewController.view.alpha = 0.0

        addChildViewController(viewController)
        setupRightBarButtonItemForSegmentedIndex(sender.selectedSegmentIndex)

        self.transitionFromViewController(currentViewController, toViewController: viewController, duration: 0.3, options: .TransitionNone, animations: {
            self.currentViewController.view.alpha = 0.0
            self.containerView.addSubview(viewController.view)
        }, completion: { finished in
            viewController.didMoveToParentViewController(self)
            viewController.view.alpha = 1.0

            self.currentViewController.view.removeFromSuperview()
            self.currentViewController?.removeFromParentViewController()
            self.currentViewController = viewController
        })
    }

    private func viewControllerForSegmentedIndex(index: Int) -> UIViewController {
        var viewController: UIViewController!

        switch index {
        case 0:
            viewController = GroupDetailViewController(group: group)
            break
        case 1:
            viewController = GroupMemberViewController(group: group)
            break
        case 2:
            viewController = GroupLiquidateViewController(group: group)
            break
        default:
            break
        }

        return viewController
    }

    private func setupRightBarButtonItemForSegmentedIndex(index: Int) {
        switch index {
        case 0:
            let barButtonImage = UIImage(named: "baricon-add-list-filled")?.imageWithRenderingMode(.AlwaysTemplate)
            let barButtonItem = UIBarButtonItem(image: barButtonImage, style: .Plain, target: self, action: #selector(self.createNewPaymentButtonClicked(_:)))

            navigationItem.setRightBarButtonItem(barButtonItem, animated: true)

            break
        case 1:
            let barButtonImage = UIImage(named: "baricon-add-user-filled")?.imageWithRenderingMode(.AlwaysTemplate)
            let barButtonItem = UIBarButtonItem(image: barButtonImage, style: .Plain, target: self, action: #selector(self.createNewMemberButtonClicked(_:)))

            navigationItem.setRightBarButtonItem(barButtonItem, animated: true)

            break
        default:
            navigationItem.setRightBarButtonItem(nil, animated: true)

            break
        }
    }

    func createNewPaymentButtonClicked(sender: AnyObject) {
        let createPaymentViewController = CreatePaymentViewController(groupid: group.id)

        navigationController?.pushViewController(createPaymentViewController, animated: true)
    }

    // TODO: - create the actual viewcontroller
    func createNewMemberButtonClicked(sender: AnyObject) {
        let createMemberViewController = CreatePaymentViewController(groupid: group.id)

        navigationController?.pushViewController(createMemberViewController, animated: true)
    }

}