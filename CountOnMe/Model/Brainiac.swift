//
//  Brainiac.swift
//  P5_01_Xcode
//
//  Created by Paul Ghibeaux on 01/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation
// MARK: - Using protocol ModelDelegate to sending information to the controller
protocol ModelDelegate: AnyObject {
    func didReceiveData(_ data: String)
}

class Brainiac {
    // Enum
    // situations: results given or error messages
    private enum ShowSituation: String {
        case isIncorrect = " Expression is incorrect "
        case haveNotEnoughElement = " Missing element to generate calcul "
        case haveResult = " Result is already showed on screen "
        case divisionByZero = " Sorry, you can't make a division by 0 "
        case unknowOperator = " Sorry, this symbol do not exist "
        case result = "result"
    }
    // MARK: - Instances
    // delegate call for receiveing data
    weak var delegate: ModelDelegate?
    // create elements var as Array that contains only the user input, and index them
    var elements: [String] {
        return elementTextView.split(separator: " ").map { "\($0)" }
    }
    // this var is used to modify the value during the operation and send to the controller for display or display an Error
    var elementTextView: String = "1 + 1 = 2" {
        didSet {
            sendToController(data: ShowSituation.result.rawValue)
        }
    }
    //  check expression validity
    private var isExpressionCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    private func expressionHaveResult(expression: String) -> Bool {
        return expression.firstIndex(of: "=") != nil
    }
    // Boolean : different checking error possible
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    // MARK: - Methods
    // appending textview with elements tapped
    func addStringToNumber(stringNumber: String) {
        if expressionHaveResult(expression: elementTextView) {
            elementTextView = ""
        }
            elementTextView += stringNumber
    }
    
    //  append numbers and operation symbols
    func addOperand(operationSymbol: String) {
        restoreLastResult(operationSymbol: operationSymbol)
        if canAddOperator {
            switch operationSymbol {
            case "+":
                elementTextView += " + "
            case "-":
                elementTextView += " - "
            case "x":
                elementTextView += " x "
            case "÷":
                elementTextView += " ÷ "
            default:
                delegate?.didReceiveData(ShowSituation.isIncorrect.rawValue)
                elementTextView = "= Error"
            }
        } else {
            // permission to Change the operator Symbol, have to remove last entry
            elementTextView.removeLast(3)
            elementTextView += (" \(operationSymbol) ")
        }
    }

    // check operation before sending to controller
     func beforeChecking() {
        guard isExpressionCorrect else {
            return sendToController(data: ShowSituation.isIncorrect.rawValue)
        }
        guard expressionHaveEnoughElement else {
            return sendToController(data: ShowSituation.haveNotEnoughElement.rawValue)
        }
        if expressionHaveResult(expression: elementTextView) {
            return sendToController(data: ShowSituation.haveResult.rawValue)
        }
        /// create a local copy of elements
        var operationsToReduce = elements
        calculate(operationsToReduce: &operationsToReduce)
    }
    // restore last result if user want to use  it for a new calcul
    private func restoreLastResult(operationSymbol: String) {
        if expressionHaveResult(expression: elementTextView) || elementTextView == "" {
            if elementTextView.prefix(7) == "= Error" || elementTextView == "" {
                    delegate?.didReceiveData(ShowSituation.isIncorrect.rawValue)
                    elementTextView = "= Error"
            } else if let lastElement = elements.last {
                elementTextView = lastElement
            }
        }
    }
    // calculate the numbers and operand used by the users  for the operation
    // using inout to allow transform operationsToReduce in this function and in his caller
    private func calculate(operationsToReduce: inout [String]) {
        while operationsToReduce.count > 1 {
            var place = 0
            if let index = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "÷"}) {
                place = index - 1
            }
            let left = Double(operationsToReduce[place])!
            let operatorSymbol = operationsToReduce[place + 1]
            let right = Double(operationsToReduce[place + 2])!
            var operationResult: Double = 0.00
            switch operatorSymbol {
            case "+":
                operationResult = left + right
            case "-":
                operationResult = left - right
            case "x":
                operationResult = left * right
            case "÷":
                operationResult = left / right
            default:
                sendToController(data: ShowSituation.unknowOperator.rawValue)
            }
            operationsToReduce.remove(at: place)
            operationsToReduce.remove(at: place)
            operationsToReduce.remove(at: place)
            operationsToReduce.insert("\(operationResult)", at: place)
        }
        afterChecking(operationsToReduce: operationsToReduce)
    }
    // last checking before sending information to the controller
    private func afterChecking(operationsToReduce: [String]) {
        if operationsToReduce.first == "inf" || operationsToReduce.first == "-inf" || operationsToReduce.first == "-nan" {
            sendToController(data: ShowSituation.divisionByZero.rawValue)
            elementTextView = "= Error"
        } else {
            elementTextView += " = \(operationsToReduce.first ?? "= Error")"
        }
    }
    // data send from the controller
    private func sendToController(data: String) {
        delegate?.didReceiveData(data)
    }
    
    // reset textView and show a clear screen
    func clearText() {
        elementTextView = ""
    }
}
