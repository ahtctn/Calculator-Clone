//
//  CalculatorViewModel.swift
//  Calculator-Clone
//
//  Created by Ahmet Ali ÇETİN on 25.04.2023.
//

import Foundation

enum CurrentNumber {
    case firstNumber
    case secondNumber
}

class CalculatorViewModel {
    
    var updateViews: (() -> Void)?
    
    //MARK: TABLE VIEW DATA SOURCE ARRAY
    let calculatorButtonCells: [CalculatorButtonModel] = [
        .allClear, .plusMinus, .percentage, .divide,
        .number(7), .number(8), .number(9), .multiply,
        .number(4), .number(5), .number(6), .divide,
        .number(1), .number(2), .number(3), .add,
        .number(0), .decimal, .equals
    ]
    
    //MARK: NORMAL VARIABLES
    private(set) lazy var calculatorHeaderLabel: String = (self.firstNumber ?? 0).description
    private(set) lazy var currentNumber: CurrentNumber = .firstNumber
    
    private(set) var firstNumber: Int? = nil {
        didSet {
            self.calculatorHeaderLabel = self.firstNumber?.description ?? "0"
        }
    }
    private(set) var secondNumber: Int? = nil {
        didSet {
            self.calculatorHeaderLabel = self.secondNumber?.description ?? "0"
        }
    }
    
    private(set) var operation: CalculatorOperationModel? = nil
    
    //MARK: MEMORY VARIABLES
    private(set) var previousNumber: Int? = nil
    private(set) var previousOperation: CalculatorOperationModel? = nil
}

extension CalculatorViewModel {
    public func didSelectButton(with calculatorButton: CalculatorButtonModel) {
        switch calculatorButton {
        case .allClear:
            self.allClearSelected()
        case .plusMinus:
            fatalError()
        case .percentage:
            fatalError()
        case .divide:
            self.didSelectOperation(with: .divide)
        case .multiply:
            self.didSelectOperation(with: .multiply)
        case .subtract:
            self.didSelectOperation(with: .subtract)
        case .add:
            self.didSelectOperation(with: .add)
        case .equals:
            self.didSelectEqualsButton()
        case .number(let int):
            self.didSelectNumber(with: int)
        case .decimal:
            fatalError()    
        }
        
        self.updateViews?()
    }
    
    private func allClearSelected() {
        self.currentNumber = .firstNumber
        self.firstNumber = nil
        self.secondNumber = nil
        self.previousNumber = nil
        self.previousOperation = nil
    }
}

//MARK: SELECTING NUMBERS
extension CalculatorViewModel {
    private func didSelectNumber(with number: Int) {
        if self.currentNumber == .firstNumber {
            if let firstNumber = self.firstNumber {
                var firstNumberString = firstNumber.description
                firstNumberString.append(number.description)
                self.firstNumber = Int(firstNumberString)
                self.previousNumber = Int(firstNumberString)
            } else {
                self.firstNumber = Int(number)
                self.previousNumber = Int(number)
            }
        } else {
            if let secondNumber = self.secondNumber {
                var secondNumberString = secondNumber.description
                secondNumberString.append(number.description)
                self.secondNumber = Int(secondNumberString)
                self.previousNumber = Int(secondNumberString)
            } else {
                self.secondNumber = Int(number)
                self.previousNumber = Int(number)
            }
        }
    }
}

//MARK: OPERATIONS
extension CalculatorViewModel {
    
    private func didSelectEqualsButton() {
        if let operation = self.operation,
           let firstNumber = self.firstNumber,
           let secondNumber = self.secondNumber {
            
            //Equals is pressed normally after firstNumber, than an operation, than a secondNumber
            let result = self.getOperationResult(operation, firstNumber, secondNumber)
            self.secondNumber = nil
            self.previousOperation = operation
            self.operation = nil
            self.firstNumber = result
            self.currentNumber = .firstNumber
        }
    }
    
    private func didSelectOperation(with operation: CalculatorOperationModel) {
        if self.currentNumber == .firstNumber {
            self.operation = operation
            self.currentNumber = .secondNumber
        } else if self.currentNumber == .secondNumber {
            if let prevOperation = self.operation,
               let firstNumber = self.firstNumber,
               let secondNumber = self.secondNumber {
                let result = self.getOperationResult(operation, firstNumber, secondNumber)
                self.secondNumber = nil
                self.firstNumber = result
                self.currentNumber = . secondNumber
                self.operation = operation
            } else {
                self.operation = operation
            }
        }
    }
    
    //MARK: OPERATION RESULT
    func getOperationResult(_ operation: CalculatorOperationModel, _ firstNumber: Int, _ secondNumber: Int) -> Int {
        switch operation {
        case .divide:
            return firstNumber / secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .add:
            return firstNumber + secondNumber
        }
    }
}
