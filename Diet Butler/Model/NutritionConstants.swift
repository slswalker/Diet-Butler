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

class Nutrition: NSObject {
	var calories: Double = 0
	var protein: Double = 0
	var fat: Double = 0
	var carbs: Double = 0
    
    var unit: ServingUnit = .Piece
    var size: Double = 0
    
    convenience init(calories: Double, protein: Double, fat: Double, carbs: Double, unit: ServingUnit, size: Double) {
        self.init()
        self.calories = calories
        self.protein = protein
        self.fat = fat
        self.carbs = carbs
        self.unit = unit
        self.size = size
    }
}


