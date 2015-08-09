//
//  Ingredient.swift
//  Diet Butler
//
//  Created by Samuel Walker on 7/18/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit

class Ingredient: Item {

	static var ingredientList: [Ingredient] = []
	class func makeIngredients() {
		// Egg
		let eggN = Nutrition(calories: 81, protein: 7.8, fat: 5.5, carbs: 0.3, unit: .Whole, size: 1)
		let egg = Ingredient(withName: "Egg")
        egg.nutrition = eggN

		//Multiseed Toast	Slice	6.1	3.7	18.5	131
        let toastN = Nutrition(calories: 131, protein: 6.1, fat: 3.7, carbs: 18.5, unit: .Slice, size: 1)
		let toast = Ingredient(withName: "Toast")
        toast.nutrition = toastN
        
        
        let cheeseN = Nutrition(calories: 90, protein: 3, fat: 5, carbs: 3, unit: .Slice, size: 1)
		let cheese = Ingredient(withName: "Cheese")
        cheese.nutrition = cheeseN
        
		ingredientList = [egg, toast, cheese]
	}

	class func addIngredient(ingredient: Ingredient) {
		self.ingredientList.append(ingredient)
	}

	class func ingredient(name: String) -> Ingredient? {
		var ingredient: Ingredient? = nil
		if let index = ingredientList.indexOf({$0.name == name}) {
			ingredient = ingredientList[index]
		}
		return ingredient
	}

    convenience init(baseIngredient: Ingredient, amount: Double) {
        self.init(withName: baseIngredient.name)
        let multiplier = amount / baseIngredient.nutrition.size
		let otherNutrition = baseIngredient.nutrition
        self.nutrition = Nutrition(calories: otherNutrition.calories * multiplier, protein: otherNutrition.protein * multiplier, fat: otherNutrition.fat * multiplier, carbs: otherNutrition.protein, unit: otherNutrition.unit, size:  amount)
    }

	override func simpleDescription() -> String {
		let b = (brand != nil) ? brand : name
		return "\(b!), \(nutrition.size) \(nutrition.unit.stringValue()), \(nutrition.calories) calories"
	}
}
