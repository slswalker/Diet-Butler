//
//  WeekTableViewController.swift
//  Diet Butler
//
//  Created by Samuel Walker on 7/18/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit

let dayCellIdentifier = "DayCellIdentifier"
let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
let daySegueIdentifier = "ShowDaySegue"

class WeekTableViewController: UITableViewController {

	@IBOutlet var menuButton: UIBarButtonItem!

	override func viewDidLoad() {
		if self.revealViewController() != nil {
			menuButton.target = self.revealViewController()
			menuButton.action = "revealToggle:"
			self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		}
        
        MemoryReporter.reportMemory()
	}

    var currentSelectedDay = 0

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 7
		} else {
			return 0
		}
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(dayCellIdentifier, forIndexPath: indexPath)
		cell.textLabel?.text = days[indexPath.row]
		return cell
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentSelectedDay = indexPath.row
		self.performSegueWithIdentifier(daySegueIdentifier, sender: self)
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == daySegueIdentifier {
			let nextVC = segue.destinationViewController as! DayTableViewController
			nextVC.navigationItem.title = days[currentSelectedDay]
		}
	}
}
