//
//  AttributeSelectionTextField.swift
//  Diet Butler
//
//  Created by Sam Walker on 7/26/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit

protocol AttributeSelectionUpdateDelegate: class {
    func pickerViewBecomeFirstResponder(pickerView: UIPickerView, fromtextField attributeTextField: AttributeSelectionTextField)
}

class AttributeSelectionTextField: UITextField, UITextFieldDelegate {
    
    var maxCharacterCount: Int = 100
    weak var pickerView: UIPickerView? = nil
    weak var selectionDelegate: AttributeSelectionUpdateDelegate? = nil
    
    var isRequired: Bool = true {
        didSet {
            if oldValue != isRequired {
                placeholder = isRequired ? "Required" : "Optional"
            }
        }
    }
    
    func setupDefaults() {
        placeholder = isRequired ? "Required" : "Optional"
        textColor = DesignConstants.Colors.ChangeableItemAttributePostColor
        delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaults()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefaults()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if (pickerView != nil) {
            selectionDelegate?.pickerViewBecomeFirstResponder(pickerView!, fromtextField: self)
            return false
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return text?.characters.count > maxCharacterCount ? false : true
    }
}
