//
//  StringInterpolationExtension.swift
//  CountdownTimer3 WatchKit Extension
//
//  Created by Arjan van der Meer on 28/12/2020.
//

import Foundation

extension String.StringInterpolation {
    mutating func appendInterpolation(if condition: @autoclosure () -> Bool, _ literal: StringLiteralType) {
        guard condition() else { return }
        appendLiteral(literal)
    }
}
