//
//  ItemSelectorTableViewController.swift
//  Diet Butler
//
//  Created by Sam Walker on 7/25/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit

let TitleCellIdentifier = "TitleCellIdentifier"

let AttributeCellIdentifier = "AttributeCellIdentifer"
class AttributeTableViewCell: UITableViewCell {
    @IBOutlet var attribute: UILabel!
    @IBOutlet var value: UILabel!
}

let SeparatorCellIdentifier = "SeparatorCellIdentifier"
class SeparatorTableViewCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!
}

class ItemSelectorTableViewController: UITableViewController {

    var ingredient: Ingredient = Ingredient()
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(attributeCreatorIdentifier, forIndexPath: indexPath) as! AttributeCreatorTableViewCell
        cell.value.tag = indexPath.row
        
        if indexPath.row > 2 {
            cell.value.keyboardType = UIKeyboardType.DecimalPad
        } else {
            cell.value.keyboardType = UIKeyboardType.Default
        }
        
        // Warning: - Not right. Correct to real classes
        switch indexPath.row {
        case 0:
            break
        case 1:
            cell.value.isRequired = false
            cell.label.text = "Brand"
            break
        case 2:
            cell.label.text = "Serving Unit"
            cell.value.text = ingredient.nutrition.unit.stringValue()
            break
        case 3:
            cell.label.text = "Serving Size"
            break
        case 4:
            cell.label.text = "Calories"
            break
        case 5:
            cell.label.text = "Protein (g)"
            break
        case 6:
            cell.label.text = "Fat (g)"
            break
        case 7:
            cell.label.text = "Carbohydrates (g)"
            break
        default:
            break
        }
        
        return cell
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
