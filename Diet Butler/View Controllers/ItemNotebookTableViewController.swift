//
//  ItemNotebookTableViewController.swift
//  Diet Butler
//
//  Created by Samuel Walker on 7/19/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit



class ItemNotebookTableViewController: UITableViewController {

    var returnsItemSelected: Bool = false
    
	private var isSectionExpanded: [Bool] = [true, true]
	private let sectionTitles = ["Ingredients", "Recipes"]
	private let itemCellIdentifer = "ItemCellIdentifier"
	private let itemHeaderCellIdentifier = "ItemHeaderCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
		if !returnsItemSelected {
            self.navigationItem.leftBarButtonItem = nil;
        }
    }
    
    // MARK: - Navigation
    @IBAction func unwindFromItemCreation(segue: UIStoryboardSegue) {
        let source = segue.sourceViewController as! ItemCreatorTableViewController
        let ingredient = source.ingredient
        
        if isSectionExpanded[0] {
            let indexPath = NSIndexPath(forRow: Ingredient.ingredientList.count, inSection: 0)
            tableView.beginUpdates()
            Ingredient.addIngredient(ingredient)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.endUpdates()
        } else {
            Ingredient.addIngredient(ingredient)
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if (section > 1 || !isSectionExpanded[section]) {return 0}
		if section == 0 {
			return Ingredient.ingredientList.count
		} else {
			return Recipe.recipeList.count
		}
	}

	override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let cell = tableView.dequeueReusableCellWithIdentifier(itemHeaderCellIdentifier)
		if let recognizers = cell?.contentView.gestureRecognizers {
			for recognizer in recognizers {
				cell?.contentView.removeGestureRecognizer(recognizer)
			}
		}

		let view = cell?.viewWithTag(99) as! UILabel
		view.text? = sectionTitles[section]
		cell?.contentView.tag = section
		let recognizer = UITapGestureRecognizer(target: self, action: "sectionHeaderTapped:")
		cell?.contentView.addGestureRecognizer(recognizer)
		return cell?.contentView
	}

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(itemCellIdentifer, forIndexPath: indexPath)
		if (indexPath.section == 0) {
			let ingredient = Ingredient.ingredientList[indexPath.row]
			cell.textLabel?.text = ingredient.name
			cell.detailTextLabel?.text = ingredient.simpleDescription()
		} else {
			let recipe = Recipe.recipeList[indexPath.row]
			cell.textLabel?.text = recipe.name
			cell.detailTextLabel?.text = recipe.simpleDescription()
		}
        return cell
    }

	func sectionHeaderTapped(recognizer: UITapGestureRecognizer) {
		let index = recognizer.view?.tag
		isSectionExpanded[index!] = !isSectionExpanded[index!]
		self.tableView.reloadSections(NSIndexSet(index: index!), withRowAnimation: .Fade)
	}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}
