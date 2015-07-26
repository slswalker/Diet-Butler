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

	var currentSelectedDay = ""

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
		currentSelectedDay = days[indexPath.row]
		cell.textLabel?.text = currentSelectedDay
		return cell
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		self.performSegueWithIdentifier(daySegueIdentifier, sender: self)
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == daySegueIdentifier {
			let nextVC = segue.destinationViewController as! DayTableViewController
			nextVC.title = currentSelectedDay
		}
	}
}