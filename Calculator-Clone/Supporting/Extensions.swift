//
//  Extensions.swift
//  Calculator-Clone
//
//  Created by Ahmet Ali ÇETİN on 26.04.2023.
//

import Foundation

extension Double {
    var toInt: Int? {
        return Int(self)
    }
}

extension String {
    var toDouble: Double? {
        return Double(self)
    }
}

extension FloatingPoint {
    var isInteger: Bool { return rounded() == self }
}
