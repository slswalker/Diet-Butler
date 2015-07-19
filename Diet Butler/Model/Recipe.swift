
//
//  Recipe.swift
//  Diet Butler
//
//  Created by Samuel Walker on 7/18/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit

class Recipe: NSObject {

	var ingredients: [Ingredient] = []
	var name: String
	var servingSize: Double
	var nutrition: Nutrition?
	
	static var recipeList: [Recipe] = []

	class func makeRecipeList() {
		// Egg, cheese, toast
		let ectRecipe = Recipe(name: "Egg cheese and toast", servingSize: 1)
		ectRecipe.ingredients.append(Ingredient.ingredient("Egg")!)
		ectRecipe.ingredients.append(Ingredient.ingredient("Toast")!)
		ectRecipe.ingredients.append(Ingredient.ingredient("Cheese")!)
		recipeList.append(ectRecipe)

		// Egg and cheese
		let ecRecipe = Recipe(name: "Egg cheese and toast", servingSize: 1)
		let egg = Ingredient(baseIngredient: Ingredient.ingredient("Egg")! , amount: 4)
		ecRecipe.ingredients.append(egg)
		ecRecipe.ingredients.append(Ingredient.ingredient("Cheese")!)
		recipeList.append(ecRecipe)
	}

	init(name: String, servingSize: Double) {
		self.name = name
		self.servingSize = servingSize
	}
	
	func addIngredient(ingredient: Ingredient, amount: Double) {
		self.ingredients.append(Ingredient(baseIngredient: ingredient, amount: amount))
	}

	func calculateNutrition() {
		var calories: Double = 0
		var protein: Double = 0
		var fat: Double = 0
		var carbs: Double = 0

		for ingredient in self.ingredients {
			let nutrition = ingredient.nutrition
			calories += nutrition.calories
			protein += nutrition.protein
			fat += nutrition.fat
			carbs += nutrition.carbs
		}

		self.nutrition = Nutrition(calories: calories, protein: protein, fat: fat, carbs: carbs)
	}
}
