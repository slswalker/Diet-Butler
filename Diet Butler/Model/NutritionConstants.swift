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
    
    static func unitAtIndex(index: Int) -> ServingUnit {
        var value: ServingUnit = .Milliliters
        switch index {
        case 1: value = .Cups
        case 2: value = .Quarts
        case 3: value = .Liter
        case 4: value = .Teaspoon
        case 5: value = .Tablespoon
        case 6: value = .Scoop
        case 7: value = .Pot
            // Weight
        case 8: value = .Grams
        case 9: value = .Pounds
            // Other
        case 10: value = .Piece
        case 11: value = .Whole
        case 12: value = .Slice
        default:
            break
        }
        return value
    }
}

struct Nutrition {
	var calories: Double = 0
	var protein: Double = 0
	var fat: Double = 0
	var carbs: Double = 0
    
    var unit: ServingUnit = .Piece
    var size: Double = 0
}

extension Nutrition {
    init(fromNutrition nutrition: Nutrition, amount: Double) {
        calories = nutrition.calories * amount
        protein = nutrition.protein * amount
        fat = nutrition.fat * amount
        carbs = nutrition.carbs * amount
        
        unit = nutrition.unit
        size = nutrition.size * amount
    }
}


