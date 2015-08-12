//
//  ItemSelectorTableViewController.swift
//  Diet Butler
//
//  Created by Sam Walker on 7/25/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit

class ItemSelectorTableViewController: UITableViewController, ItemMadeProtocol {

    var item: Item?
    var servingSize: Double = 1.0
    
    private let attributeCreatorIdentifier = "SelectorAttributeCreatorIdentifier"
    private let attributePresenterIdentifier = "AttributePresenterIdentifier"
    
    private weak var caloriesLabel: UILabel?
    private weak var proteinLabel: UILabel?
    private weak var fatLabel: UILabel?
    private weak var carbsLabel: UILabel?
    
    @IBOutlet var rightBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = item!.name
        rightBarButtonItem.enabled = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidAppear:", name: UIKeyboardDidShowNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.sourceViewController == self {
            item = Ingredient(baseIngredient: (item as! Ingredient), amount: servingSize)
        }
    }

    // for later
//    func keyboardWillAppear(notification: NSNotification){
//        if let info: NSDictionary = notification.userInfo,
//            value: NSValue = info[UIKeyboardFrameEndUserInfoKey] as? NSValue,
//            rect: CGRect = value.CGRectValue(),
//            durationValue = info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber,
//            animationCurve = info[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
//        {
//
//            let curve = animationCurve.integerValue
//            let curveValue = UIViewAnimationCurve(rawValue: curve)
//            let duration = durationValue.doubleValue
//            let minY = min(0, rect.origin.y - (64 + tableView.contentSize.height))
//            let point = CGPointMake(0, minY)
//            
//            UIView.beginAnimations(nil, context: nil)
//            UIView.setAnimationBeginsFromCurrentState(true)
//            UIView.setAnimationDuration(duration)
//            UIView.setAnimationCurve(curveValue!)
//            tableView.setContentOffset(point, animated: true)
//            UIView.commitAnimations()
//        }
//    }
    
    func keyboardDidAppear(notification: NSNotification) {
        
        let indexPath = NSIndexPath(forRow: 3, inSection: 1)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((section == 0) ? 2 : 4)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0 && indexPath.row == 1) {
            let cell = tableView.dequeueReusableCellWithIdentifier(attributeCreatorIdentifier, forIndexPath: indexPath) as! AttributeCreatorTableViewCell
            cell.label.text = "Servings"
            cell.value.keyboardType = UIKeyboardType.DecimalPad
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(attributePresenterIdentifier, forIndexPath: indexPath) as! AttributePresenterTableViewCell
            
            if indexPath.section == 0 {
                cell.label.text = "Serving Unit"
                cell.valueLabel.text = item!.nutrition.unit.stringValue()
                return cell
            }
            
            // Warning: - Not right. Correct to real classes
            switch indexPath.row {
            case 0:
                cell.label.text = "Calories"
                caloriesLabel = cell.valueLabel
                break
            case 1:
                cell.label.text = "Protein (g)"
                proteinLabel = cell.valueLabel
                break
            case 2:
                cell.label.text = "Fat (g)"
                fatLabel = cell.valueLabel
                break
            case 3:
                cell.label.text = "Carbohydrates (g)"
                carbsLabel = cell.valueLabel
                break
            default:
                break
            }
            
            configureLabelForTag(indexPath.row)
            
            return cell
        }
    }
    
    
    @IBAction func editingDidBegin(sender: AnyObject) {
        let indexPath = NSIndexPath(forRow: 3, inSection: 1)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    @IBAction func editingChanged(sender: AttributeSelectionTextField) {
        if let stringValue = sender.text,
            value = Double(stringValue)
        {
            rightBarButtonItem.enabled = true
            if value != servingSize {
                servingSize = value
                calculateNutrientInformation()
            }
        } else {
            rightBarButtonItem.enabled = false
        }
    }
    
    private func calculateNutrientInformation() {
        for i in 0...3 {
            configureLabelForTag(i)
        }
    }
    
    private func configureLabelForTag(tag: Int) {
        let nutrition = item!.nutrition
        let ratio = servingSize / nutrition.size
        switch tag {
        case 0:
            caloriesLabel!.text = "\(nutrition.calories) | \(nutrition.calories * ratio)"
            break
        case 1:
            proteinLabel!.text = "\(nutrition.protein) | \(nutrition.protein * ratio)"
            break
        case 2:
            fatLabel!.text = "\(nutrition.fat) | \(nutrition.fat * ratio)"
            break
        case 3:
            carbsLabel!.text = "\(nutrition.carbs) | \(nutrition.carbs * ratio)"
            break
        default:
            break
        }
    }
}