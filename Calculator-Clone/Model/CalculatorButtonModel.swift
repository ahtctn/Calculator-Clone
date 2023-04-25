//
//  CalculatorButtonModel.swift
//  Calculator-Clone
//
//  Created by Ahmet Ali ÇETİN on 25.04.2023.
//

import UIKit

enum CalculatorButtonModel {
    case allClear
    case plusMinus
    case percentage
    case divide
    case multiply
    case subtract
    case add
    case equals
    case number(Int)
    case decimal
    
    init(calculatorButton: CalculatorButtonModel) {
        switch calculatorButton {
        case .allClear, .plusMinus, .percentage, .divide, .multiply, .subtract, .add, .equals, .decimal:
            self = calculatorButton
        case .number(let int):
            if int.description.count == 1 {
                self = calculatorButton
            } else {
                fatalError("It is not 1 digit")
            }
        }
    }
}

extension CalculatorButtonModel {
    var title: String {
        switch self {
        case .allClear:
            return "AC"
        case .plusMinus:
            return "+/-"
        case .percentage:
            return "%"
        case .divide:
            return "÷"
        case .multiply:
            return "x"
        case .subtract:
            return "-"
        case .add:
            return "+"
        case .equals:
            return "="
        case .number(let int):
            return int.description
        case .decimal:
            return "."
        }
    }
    
    var color: UIColor {
        switch self {
        case .allClear, .plusMinus, .percentage:
            return .lightGray
        case .divide, .multiply, .subtract, .add, .equals:
            return .systemOrange
        case .number, .decimal:
            return .darkGray
        }
    }
    
    var selectedColor: UIColor? {
        switch self {
        case .allClear, .plusMinus, .percentage:
            return .white 
        case .divide, .multiply, .subtract, .add, .equals:
            return .systemYellow
        case .number, .decimal:
            return .systemGray5
        }
    }
}
