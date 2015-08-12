//
//  Item.swift
//  Diet Butler
//
//  Created by Sam Walker on 7/25/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit

class Item {
    var name: String
    var nutrition: Nutrition
    var brand: String? = nil
    
    init() {
        self.name = ""
        self.nutrition = Nutrition()
    }
    
    convenience init(withName name:String) {
        self.init()
        nutrition = Nutrition()
        self.name = name
    }
    
    convenience init(withItem item: Item) {
        self.init()
        nutrition = item.nutrition
        name = item.name
        brand = item.brand
    }
    
    func simpleDescription() -> String {return ""}
}
