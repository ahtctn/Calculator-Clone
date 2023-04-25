//
//  CalculatorViewModel.swift
//  Calculator-Clone
//
//  Created by Ahmet Ali ÇETİN on 25.04.2023.
//

import Foundation

class CalculatorViewModel {
    //MARK: TABLE VIEW DATA SOURCE ARRAY
    
    let calculatorButtonCells: [CalculatorButtonModel] = [
        .allClear, .plusMinus, .percentage, .divide,
        .number(7), .number(8), .number(9), .multiply,
        .number(4), .number(5), .number(6), .divide,
        .number(1), .number(2), .number(3), .add,
        .number(0), .decimal, .equals
    ]
    
    private(set) lazy var calculatorHeaderLabel: String = "43"
    
}
