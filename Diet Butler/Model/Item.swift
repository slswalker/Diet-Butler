//
//  Item.swift
//  Diet Butler
//
//  Created by Sam Walker on 7/25/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name: String
    var nutrition: Nutrition
    var brand: String? = nil
    
    override init() {
        self.name = ""
        self.nutrition = Nutrition()
    }
    
    convenience init(withName name:String) {
        self.init()
        self.nutrition = Nutrition()
        self.name = name
    }
}
