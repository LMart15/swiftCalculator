//
//  ViewController.swift
//  swiftCalc
//
//  Created by Lawrence Martin on 2017-01-17.
//  Copyright © 2017 mapd.centennial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var operandStack = [Double]()
    var operatorSym: String?
    var userIsInTheMiddleOfTypingANumber = false
    var digitHasDecimal = false
    
    // not used for user typing, just calculations
    var displayValue: Double {
        get {
            return Double(displayNumber_lbl.text!)!
        }
        set {
            // remove ".0" from display
            if newValue == floor(newValue) {
                displayNumber_lbl.text = "\(Int(newValue))"
            } else {
                displayNumber_lbl.text = "\(newValue)"
            }
            
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBOutlet weak var displayNumber_lbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //displayNumber_lbl.text = ("\(displayNum)")
    }
    

    @IBAction func operationInputHandler(_ sender: UIButton) {
        userIsInTheMiddleOfTypingANumber = false
        operatorSym = sender.currentTitle
        operandStack.append(Double(displayNumber_lbl.text!)!)
    }
    
    @IBAction func numberInputHandler(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            displayNumber_lbl.text! += digit
        } else {
            displayNumber_lbl.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func equalsInputHandler(_ sender: UIButton) {
        
        if operatorSym != nil {
            userIsInTheMiddleOfTypingANumber = false
            operandStack.append(displayValue)
            
            switch operatorSym! {
            case "+": performOperation() { $0 + $1 }
            case "-": performOperation() { $1 - $0 }
            case "x": performOperation() { $0 * $1 }
            case "/": performOperation() { $1 / $0 }
                
            default: break
            }
            
            print("\(operandStack) " + operatorSym!)
        }
        
    }
    
    @IBAction func clearDisplay(_ sender: Any) {
        operandStack.removeAll()
        userIsInTheMiddleOfTypingANumber = false
        operatorSym = nil
        displayValue = 0
    }
    
    func performOperation( operation: (Double, Double) -> Double)  {
        displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
        print("\(displayValue) ")
        operandStack.append(displayValue)
    }

}

