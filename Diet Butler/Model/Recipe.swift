
//
//  Recipe.swift
//  Diet Butler
//
//  Created by Samuel Walker on 7/18/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit

class Recipe: Item {

	var ingredients: [Ingredient] = []
	
	static var recipeList: [Recipe] = []

	class func makeRecipeList() {
		// Egg, cheese, toast
        
        let ingredientsECT = [Ingredient.ingredient("Egg")!, Ingredient.ingredient("Toast")!, Ingredient.ingredient("Cheese")!]
        let ectRecipe = Recipe(withName: "Egg cheese and toast", ingredients: ingredientsECT, servingSize: 1)
		recipeList.append(ectRecipe)

		// Omelet
        let ingredientsOmelet = [Ingredient(baseIngredient: Ingredient.ingredient("Egg")! , amount: 4), Ingredient.ingredient("Cheese")!]
        
        let ecRecipe = Recipe(withName: "Omelet", ingredients: ingredientsOmelet, servingSize: 1)
		recipeList.append(ecRecipe)
	}
    
    convenience init(withName name: String, ingredients: [Ingredient], servingSize: Double) {
        self.init(withName: name)
        self.ingredients = ingredients
        self.nutrition.size = servingSize
        self.calculateNutrition()
    }
	
	func addIngredient(ingredient: Ingredient, amount: Double) {
		self.ingredients.append(Ingredient(baseIngredient: ingredient, amount: amount))
        calculateNutrition()
	}
    
    func addIngredients(ingredients: [Ingredient]) {
        self.ingredients += ingredients
        calculateNutrition()
    }

    func calculateNutrition() {
		var calories: Double = 0
		var protein: Double = 0
		var fat: Double = 0
		var carbs: Double = 0
        let size: Double = nutrition.size

		for ingredient in self.ingredients {
			let nutrition = ingredient.nutrition
			calories += nutrition.calories
			protein += nutrition.protein
			fat += nutrition.fat
			carbs += nutrition.carbs
		}

        self.nutrition = Nutrition(calories: calories, protein: protein, fat: fat, carbs: carbs, unit: .Piece, size: size)
	}

	func simpleDescription() -> String {
		return "\(nutrition.size) serving size, \(nutrition.calories) calories"
	}
}
