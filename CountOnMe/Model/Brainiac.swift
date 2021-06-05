//
//  Brainiac.swift
//  P5_01_Xcode
//
//  Created by Paul Ghibeaux on 01/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit


enum operationSymbol {
    case plus, minus, multiply, divided
}


class Brainiac {
     
    // MARK: - Properties

    var numberArray = [String()]
    var operandSymbol = ["+"]
    
    weak var delegateAlertMessage: VCAlertDelegate?
    
    // MARK: - append numbers and operation symbols

    /// - parameter newNumber: The number input by the user
 
    func operationsNumbers(_ newNumber: Int){
        if let number = numberArray.last {
            var numberMutable = number
            numberMutable += ("\(newNumber)")
                numberArray[numberArray.count-1] = numberMutable
        }
    }
    /**
     Append an operation symbol to an array
     - parameter symbol: A binary operation symbol input by the user
     */
    
    func appendOperandSymbol(_ symbol : operationSymbol){
        switch symbol {
        case .plus:
            operandSymbol.append("+")
            numberArray.append("")
        case .minus:
            operandSymbol.append("-")
            numberArray.append("")
        case .multiply:
            operandSymbol.append("*")
            numberArray.append("")
        case .divided:
            operandSymbol.append("/")
            numberArray.append("")
        }
    }
    
    // MARK: - calculate

    func result() -> Int {
        var result = 0
        for (index, stringNumber) in numberArray.enumerated() {
            operandBrain(stringNumber, index, &result)
        }
        return result
    }
   
    func operandBrain(_ stringNumber: String, _ index: Int , _ result: inout Int ) {
        if let number = Int(stringNumber) {
            if operandSymbol[index] == "+" {
                result += number
            } else if operandSymbol[index] == "-" {
                result -= number
            } else if operandSymbol[index] == "*" {
                result *= number
            } else if operandSymbol[index] == "/" {
                result /= number
            }
        }
    }
    
    // MARK: - check validity

    func checkappendOperand(with symbol: operationSymbol) -> Bool {
        if let stringNumber = numberArray.last {
            if stringNumber.isEmpty {
                return false
            }
            
        }
        appendOperandSymbol(symbol)
        return true
    }
    
    func isExpressionCorrect() -> Bool {
        if numberArray.count == 1 {
            delegateAlertMessage?.presentVCAlert(with: "Démarrez un nouveau calcul !")
            return false
            
        } else if numberArray.last == "" {
            delegateAlertMessage?.presentVCAlert(with: "Entrez une expression correcte !")
            return false
        }
        return true
    }
    
    func clearArrays() {
        numberArray = [String()]
        operandSymbol = ["+"]
    }
    
}

