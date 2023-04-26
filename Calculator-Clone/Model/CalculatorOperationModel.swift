//
//  CalculatorOperationModel.swift
//  Calculator-Clone
//
//  Created by Ahmet Ali ÇETİN on 26.04.2023.
//

import Foundation

enum CalculatorOperationModel {
    case divide
    case multiply
    case subtract
    case add
    
    var title: String {
        switch self {
        case .divide:
            return "÷"
        case .multiply:
            return "x"
        case .subtract:
            return "-"
        case .add:
            return "+"
        }
    }
}
