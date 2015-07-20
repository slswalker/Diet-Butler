//
//  Ingredient.swift
//  Diet Butler
//
//  Created by Samuel Walker on 7/18/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit

class Ingredient: NSObject {

	var name: String
	var brand: String = ""
	var nutrition: Nutrition
	var size: Double
	var unit: ServingUnit

	static var ingredientList: [Ingredient] = []
	class func makeIngredients() {
		// Egg
		let eggN = Nutrition(calories: 81, protein: 7.8, fat: 5.5, carbs: 0.3)
		let egg = Ingredient(name: "Egg", nutrition: eggN, size: 1, unit: .Whole)

		//Multiseed Toast	Slice	6.1	3.7	18.5	131
		let toastN = Nutrition(calories: 131, protein: 6.1, fat: 3.7, carbs: 18.5)
		let toast = Ingredient(name: "Toast", nutrition: toastN, size: 1, unit: .Slice)

		let cheeseN = Nutrition(calories: 90, protein: 3, fat: 5, carbs: 3)
		let cheese = Ingredient(name: "Cheese", nutrition: cheeseN, size: 1, unit: .Slice)

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

	init(name: String, nutrition: Nutrition, size: Double, unit: ServingUnit) {
		self.nutrition = nutrition
		self.size = size
		self.unit = unit
		self.name = name
	}

	init(baseIngredient: Ingredient, amount: Double) {
		self.name = baseIngredient.name
		let multiplier = amount / baseIngredient.size
		let otherNutrition = baseIngredient.nutrition
		self.nutrition = Nutrition(calories: otherNutrition.calories * multiplier, protein: otherNutrition.protein * multiplier, fat: otherNutrition.fat * multiplier, carbs: otherNutrition.protein)
		self.size = amount
		self.unit = baseIngredient.unit
	}

	func simpleDescription() -> String {
		let b = (brand != "") ? brand : name
		return "\(b), \(size) \(unit.stringValue()), \(nutrition.calories) calories"
	}
}
