//
//  DayTableViewController.swift
//  Diet Butler
//
//  Created by Samuel Walker on 7/18/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit


class DayTableViewController: UITableViewController {

	var items: [Item] = []
	let entryCellIentifier = "EntryCellIentifier"
	var currentSelectedDay = ""

    @IBAction   func unwindToDayCancel(segue: UIStoryboardSegue) {
        print("unwindToDayCancel")
    }
    
    @IBAction   func unwindToDayDone(segue: UIStoryboardSegue) {
        let source = segue.sourceViewController as! ItemNotebookTableViewController
        if let item = source.itemSelected {
            tableView.beginUpdates()
            items.append(item)
            let indexPath = NSIndexPath(forRow:0 , inSection: 0)
            let array = [indexPath]
            tableView.insertRowsAtIndexPaths(array, withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.endUpdates()
        }
        print("unwindToDayDone")
    }
    
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
		if segue.identifier == "ItemNotebookStoryboardID" {
			let navController = segue.destinationViewController as! UINavigationController
            let nextVC = navController.topViewController as! ItemNotebookTableViewController
//            let nextVC = segue.destinationViewController as! ItemNotebookTableViewController
            nextVC.returnsItemSelected = true
		}
	}
}
