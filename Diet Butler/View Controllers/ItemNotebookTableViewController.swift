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
    var itemSelected: Item?
    
	private var isSectionExpanded: [Bool] = [true, true]
	private let sectionTitles = ["Ingredients", "Recipes"]
	private let itemCellIdentifer = "ItemCellIdentifier"
	private let itemHeaderCellIdentifier = "ItemHeaderCellIdentifier"
    private let itemSelectionDoneIdentifier = "ItemSelectionDoneIdentifier"
    private let itemCreatorCellIdentifier = "ItemCreatorCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
		if !returnsItemSelected {
            if self.revealViewController() != nil {
                let menuButton = UIBarButtonItem(image: UIImage(imageLiteral: "menu.png"), style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
                self.navigationItem.leftBarButtonItem = menuButton
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            }
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
			return Ingredient.ingredientList.count + 1
		} else {
			return Recipe.recipeList.count + 1
		}
	}

    override func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 35.0;
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35;
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
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(itemCreatorCellIdentifier, forIndexPath: indexPath)
            
            if indexPath.section == 0 {
                cell.textLabel?.text = "Create a new ingredient"
            } else {
                cell.textLabel?.text = "Create a new recipe"
            }
//            cell.detailTextLabel?.text = ""
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(itemCellIdentifer, forIndexPath: indexPath)

            let index = indexPath.row - 1;
            var item: Item? = nil
            if (indexPath.section == 0) {
                item = Ingredient.ingredientList[index]
                
            } else {
                item = Recipe.recipeList[index]
            }
            cell.textLabel?.text = item?.name
            cell.detailTextLabel?.text = item?.simpleDescription()
            return cell;
        }
    }

	func sectionHeaderTapped(recognizer: UITapGestureRecognizer) {
		let index = recognizer.view?.tag
        
        if !isSectionExpanded[index!] {
            self.expandSection(index!)
        } else {
            self.collapseSection(index!)
//            isSectionExpanded[index!] = !isSectionExpanded[index!]
//            self.tableView.reloadSections(NSIndexSet(index: index!), withRowAnimation: .Fade)
        }
        
		
	}
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if returnsItemSelected {
            // TODO: Present item picker / editor
            if indexPath.section == 0 {
                itemSelected = Ingredient.ingredientList[indexPath.row]
            } else {
                itemSelected = Recipe.recipeList[indexPath.row]
            }
            
            performSegueWithIdentifier(itemSelectionDoneIdentifier, sender: self);
        } else {
            // Item Editor?
        }
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return !returnsItemSelected
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete && !returnsItemSelected {
            if indexPath.section == 0 {
                Ingredient.ingredientList.removeAtIndex(indexPath.row)
            } else {
                Recipe.recipeList.removeAtIndex(indexPath.row)
            }
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func expandSection(index: NSInteger) {
        if isSectionExpanded[index] { return }
        
        isSectionExpanded[index] = true
        
        var indexArray: [NSIndexPath] = []
        
        self.tableView.beginUpdates()
        
        switch index {
        case 0:
            for x in 0...Ingredient.ingredientList.count {
                let indexPath = NSIndexPath(forRow: x, inSection: index)
                print(indexPath)
                indexArray.append(indexPath)
            }
            break
        case 1:
            for x in 0...Recipe.recipeList.count {
                let indexPath = NSIndexPath(forRow: x, inSection: index)
                print(indexPath)
                indexArray.append(indexPath)
            }
            break
        default:
            break
        }
        
        
        self.tableView.insertRowsAtIndexPaths(indexArray, withRowAnimation: UITableViewRowAnimation.Fade)
        
        self.tableView.endUpdates()
    }
    
    func collapseSection(index: NSInteger) {
        if !isSectionExpanded[index] { return }
        
        isSectionExpanded[index] = false
        
        var indexArray: [NSIndexPath] = []
        
        self.tableView.beginUpdates()
        
        switch index {
        case 0:
            for x in 0...Ingredient.ingredientList.count {
                let indexPath = NSIndexPath(forRow: x, inSection: index)
                print(indexPath)
                indexArray.append(indexPath)
            }
            break
        case 1:
            for x in 0...Recipe.recipeList.count {
                let indexPath = NSIndexPath(forRow: x, inSection: index)
                print(indexPath)
                indexArray.append(indexPath)
            }
            break
        default:
            break
        }
    
        self.tableView.deleteRowsAtIndexPaths(indexArray, withRowAnimation: UITableViewRowAnimation.Fade)
        
        self.tableView.endUpdates()
    }
}
