//
//  ItemCreatorTableViewController.swift
//  Diet Butler
//
//  Created by Sam Walker on 7/25/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit

public class BaseItemTableViewCell: UITableViewCell {
    @IBOutlet var label: UILabel!
}

let attributeCreatorIdentifier = "AttributeCreatorIdentifier"
public class AttributeCreatorTableViewCell: BaseItemTableViewCell {
    @IBOutlet var value: AttributeSelectionTextField!
}

class ItemCreatorTableViewController: UITableViewController, UITextFieldDelegate {
    
    var ingredient: Ingredient = Ingredient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        
        switch indexPath.row {
        case 0:
            break
        case 1:
            cell.value.isRequired = false
            cell.label.text = "Brand"
            break
        case 2:
            cell.label.text = "Serving Unit"
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
    
    @IBAction func savePressed(object: AnyObject) {
        if checkForValidSaveOption() {
            performSegueWithIdentifier("unwindFromSaveIngredientIdentifier", sender: self)
        } else {
            let alert = UIAlertController(title: "Uh oh", message: "You have not completed the required rows", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    @IBAction func editingChanged(sender: AttributeSelectionTextField) {
        var value = 0.0
        if sender.tag > 2 {
            let index = sender.tag - 2
            if let text = sender.text {
                if text.characters.count > 0 {
                    value = (NSString(string: text)).doubleValue
                }
            }
            
            switch index {
            case 3:
                ingredient.nutrition.size = value
                break
            case 4:
                ingredient.nutrition.calories = value
                break
            case 5:
                ingredient.nutrition.protein = value
                break
            case 6:
                ingredient.nutrition.fat = value
                break
            case 7:
                ingredient.nutrition.carbs = value
                break
            default:
                break
            }
            
        } // TODO: Serving Unit Selection
            
        if let text = sender.text {
            if text.characters.count > 0 {
                if sender.tag == 1 {
                    ingredient.brand = text
                } else if sender.tag == 0 {
                    ingredient.name = text
                }
            }
        }
    }
    
    func checkForValidSaveOption() -> Bool {
        return ingredient.name != "" && ingredient.nutrition.calories > 0 && ingredient.nutrition.size > 0 &&
        (ingredient.nutrition.protein > 0 || ingredient.nutrition.fat > 0 || ingredient.nutrition.carbs > 0)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
