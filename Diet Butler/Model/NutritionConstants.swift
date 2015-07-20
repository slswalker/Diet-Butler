//
//  NutritionConstants.swift
//  Diet Butler
//
//  Created by Samuel Walker on 7/18/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

import UIKit

enum ServingUnit {
	// Volume
	case Milliliters, Cups, Quarts, Liter, Teaspoon, Tablespoon, Scoop, Pot
	// Weight
	case Grams, Pounds
	// Other
	case Piece, Whole, Slice

	func stringValue() -> String {
		var value = ""
		switch self {
		case .Milliliters: value = "ml"
		case .Cups: value = "Cups"
		case .Quarts: value = "Qrts"
		case .Liter: value = "L"
		case .Teaspoon: value = "tbsp"
		case .Tablespoon: value = "Tbsp"
		case .Scoop: value = "Scoops"
		case .Pot: value = "Pots"
			// Weight
		case .Grams: value = "g"
		case .Pounds: value = "lbs"
			// Other
		case .Piece: value = "Pieces"
		case .Whole: value = "Whole"
		case .Slice: value = "Slices"
		}
		return value
	}
}

struct Entry {
	var ingredient: Ingredient?
	var recipe: Recipe?
}

struct Nutrition {
	var calories: Double
	var protein: Double
	var fat: Double
	var carbs: Double
}


