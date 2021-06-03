//
//  Brainiac.swift
//  P5_01_Xcode
//
//  Created by Paul Ghibeaux on 01/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit


protocol VCAlert: ViewController {
    func presentVCAlert(with: String)
}

class Brainiac {
    private var accumulator = 0.0
    private var internalProgram = [AnyObject]()
    /// Store numbers
    var numberArray = [String()]
    
    weak var delegateAlertMessage: VCAlert?
    
    
    private var operations: Dictionary<String,Operation> = [
        "÷" : Operation.binaryOperation({ $0 / $1}),
        "+" : Operation.binaryOperation({ $0 + $1}),
        "−" : Operation.binaryOperation({ $0 - $1}),
        "×" : Operation.binaryOperation({ $0 * $1}),
        "=" : Operation.Equals
        ]
    
    private enum Operation {
        case binaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func setOperand(_ operand: Double) {
    accumulator = operand
        internalProgram.append(operand as AnyObject)
    }
    
   

    func performOperation(_ symbol : String){
        internalProgram.append(symbol as AnyObject)
        
        if let Operation = operations[symbol]{
            switch Operation {
             case .binaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }}
        }
    
    private func executePendingBinaryOperation (){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending =  nil
            
        }
    }
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
        
    }
    
    typealias PropertyList = AnyObject
    
    var program: PropertyList {
        get {
            return internalProgram as Brainiac.PropertyList
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject]{
                for op in arrayOfOps{
                    if let operand = op as? Double {
                      setOperand(operand)
                    } else if let Operation = op as? String {
                        performOperation(Operation)
                    }
                
                }
            }
            
        }
    }
    func clear () {
        accumulator = 0.0
        pending = nil
        
        internalProgram.removeAll()
    }
    
    /**
     Verify the validity of the binary operations to be calculated.
     Call delegate method when invalid
     - Returns: Bool
     */
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
    

  var result: Double {
        get {
            return accumulator
            
        }
    }
    
}

extension VCAlert {
    func presentVCAlert(with message: String) {
        let alertVC = UIAlertController(title: "Erreur !", message: message, preferredStyle: .alert)

        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        self.present(alertVC, animated: true, completion: nil)
    }
}
