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
}

struct Nutrition {
	var calories: Double
	var protein: Double
	var fat: Double
	var carbs: Double
}


