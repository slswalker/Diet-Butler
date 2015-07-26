//
//  DayTableViewController.swift
//  Diet Butler
//
//  Created by Samuel Walker on 7/18/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit


class DayTableViewController: UITableViewController {

	var items: [AnyObject] = []
	let entryCellIentifier = "EntryCellIentifier"
	var currentSelectedDay = ""

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(entryCellIentifier, forIndexPath: indexPath)

		let entry = items[indexPath.row]
		if (entry is Ingredient) {
			let ingredient = entry as! Ingredient
			cell.textLabel?.text = ingredient.name
			cell.detailTextLabel?.text = ingredient.simpleDescription()
		} else if (entry is Recipe) {
			let recipe = entry as! Recipe
			cell.textLabel?.text = recipe.name
			cell.detailTextLabel?.text = recipe.simpleDescription()
		}
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