//
//  AttributeSelectionTextField.swift
//  Diet Butler
//
//  Created by Sam Walker on 7/26/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit

protocol AttributeSelectionUpdateDelegate: class {
    func attributeSelector(attributeSelector selector:AttributeSelectionTextField, withValue value: String)
}

class AttributeSelectionTextField: UITextField, UITextFieldDelegate {
    
    var maxCharacterCount: Int = 100
    
    var isRequired: Bool = false {
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
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return text?.characters.count > maxCharacterCount ? false : true
    }
}
