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
        let source = segue.sourceViewController as! ItemMadeProtocol
        if let item = source.item {
            addItem(item)
        }
    }
    
    private func addItem(item: Item) {
        tableView.beginUpdates()
        items.append(item)
        let index = (items.count - 1)
        let indexPath = NSIndexPath(forRow:index , inSection: 0)
        let array = [indexPath]
        tableView.insertRowsAtIndexPaths(array, withRowAnimation: UITableViewRowAnimation.Automatic)
        tableView.endUpdates()
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

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "ItemNotebookStoryboardID" {
			let navController = segue.destinationViewController as! UINavigationController
            let nextVC = navController.topViewController as! ItemNotebookTableViewController
            nextVC.returnsItemSelected = true
		}
	}
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}
