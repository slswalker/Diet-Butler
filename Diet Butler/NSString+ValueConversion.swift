//
//  NSString+ValueConversion.swift
//  Diet Butler
//
//  Created by Sam Walker on 8/11/15.
//  Copyright © 2015 Samuel Walker. All rights reserved.
//

extension String {
    struct StringNumberFormatter {
        static let formatter = NSNumberFormatter()
    }
    
    func toInt() -> Int? {
        return StringNumberFormatter.formatter.numberFromString(self)?.integerValue
    }
    
    func toFloat() -> Float? {
        return StringNumberFormatter.formatter.numberFromString(self)?.floatValue
    }
    
    func toDouble() -> Double? {
        return StringNumberFormatter.formatter.numberFromString(self)?.doubleValue
    }
}