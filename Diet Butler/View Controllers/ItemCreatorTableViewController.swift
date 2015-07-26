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

class ItemCreatorTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, AttributeSelectionUpdateDelegate {
    
    @IBOutlet var unitPickerView: UIPickerView!
    weak var editingAttributeTextField: AttributeSelectionTextField? = nil
    
    var ingredient: Ingredient = Ingredient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
        
        switch indexPath.row {
        case 0:
            break
        case 1:
            cell.value.isRequired = false
            cell.label.text = "Brand"
            break
        case 2:
            cell.label.text = "Serving Unit"
            cell.value.pickerView = unitPickerView
            cell.value.selectionDelegate = self
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
    
    // MARK: - Picker view data source
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 13
    }
    
    // MARK: - Pick view delegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ServingUnit.unitAtIndex(row).stringValue()
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ingredient.nutrition.unit = ServingUnit.unitAtIndex(row)
        pickerView.removeFromSuperview()
        editingAttributeTextField?.text = ingredient.nutrition.unit.stringValue()
        editingAttributeTextField = nil
    }
    
    // MARK: - IBActions
    
    @IBAction func savePressed(object: AnyObject) {
        if checkForValidSaveOption() {
            performSegueWithIdentifier("unwindFromSaveIngredientIdentifier", sender: self)
        } else {
            let alert = UIAlertController(title: "Uh oh", message: "You have not completed the required rows", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - AttributeSelectionTextField

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
            
        }
            
        if let text = sender.text {
            if text.characters.count > 0 {
                if sender.tag == 1 {
                    ingredient.brand = text
                } else if sender.tag == 0 {
                    ingredient.name = text
                    navigationItem.title = text
                }
            }
        }
    }
    
    func pickerViewBecomeFirstResponder(pickerView: UIPickerView, fromtextField attributeTextField: AttributeSelectionTextField) {
        editingAttributeTextField = attributeTextField
        view.endEditing(true)
        pickerView.frame = self.view.bounds
        view.addSubview(pickerView)
    }
    
    // MARK: - Helper
    
    func checkForValidSaveOption() -> Bool {
        return ingredient.name != "" && ingredient.nutrition.calories > 0 && ingredient.nutrition.size > 0 &&
        (ingredient.nutrition.protein > 0 || ingredient.nutrition.fat > 0 || ingredient.nutrition.carbs > 0)
    }
}
