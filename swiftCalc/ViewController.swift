//
//  ViewController.swift
//  swiftCalc
//
//  Created by Lawrence Martin on 2017-01-17.
//  Copyright © 2017 mapd.centennial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var inputStack = [Double]()
    var operatorSym: String?
    var userActive = false
    var digitHasDecimal = false
    
    var displayValue: Double {
        get {
            return Double(displayNumber_lbl.text!)!
        }
        set {
            if newValue == floor(newValue) {
                displayNumber_lbl.text = "\(Int(newValue))"
            } else {
                displayNumber_lbl.text = "\(newValue)"
            }
            
            userActive = false
        }
    }
    
    @IBOutlet weak var displayNumber_lbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //displayNumber_lbl.text = ("\(displayNum)")
    }
    

    @IBAction func operationInputHandler(_ sender: UIButton) {
        userActive = false
        operatorSym = sender.currentTitle
        inputStack.append(Double(displayNumber_lbl.text!)!)
    }
    
    @IBAction func numberInputHandler(_ sender: UIButton) {
        
        let displayNum = sender.currentTitle!
        if userActive {
            displayNumber_lbl.text! += displayNum
        } else {
            displayNumber_lbl.text = displayNum
            userActive = true
        }
    }
    
    @IBAction func equalsInputHandler(_ sender: UIButton) {
        
        if operatorSym != nil {
            userActive = false
            inputStack.append(displayValue)
            
            switch operatorSym! {
            case "+": performOperation() { $0 + $1 }
            case "-": performOperation() { $1 - $0 }
            case "x": performOperation() { $0 * $1 }
            case "/": performOperation() { $1 / $0 }
                
            default: break
            }
            
            print("\(inputStack) " + operatorSym!)
        }
        
    }
    
    @IBAction func clearDisplay(_ sender: Any) {
        inputStack.removeAll()
        userActive = false
        operatorSym = nil
        displayValue = 0
    }
    
    func performOperation( operation: (Double, Double) -> Double)  {
        displayValue = operation(inputStack.removeLast(), inputStack.removeLast())
        print("\(displayValue) ")
        inputStack.append(displayValue)
    }

}

