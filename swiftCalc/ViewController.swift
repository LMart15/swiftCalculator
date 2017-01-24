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
    @IBOutlet weak var decimalBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayNumber_lbl.text = ("\(0)")
    }
    

    @IBAction func operationInputHandler(_ sender: UIButton) {
        userActive = false
        self.digitHasDecimal = false
        operatorSym = sender.currentTitle
        inputStack.append(Double(displayNumber_lbl.text!)!)
    }
    
    @IBAction func numberInputHandler(_ sender: UIButton) {
        
        let displayNum = sender.currentTitle!
        if self.digitHasDecimal {self.decimalBtn.isEnabled = false}
        else {self.decimalBtn.isEnabled = true}
        
        if displayNum.contains("."){ digitHasDecimal = true}
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
            case "+": doCalculation() { $0 + $1 }
            case "-": doCalculation() { $1 - $0 }
            case "x": doCalculation() { $0 * $1 }
            case "/": doCalculation() { $1 / $0 }
                
            default: break
            }
            
            print("\(inputStack) " + operatorSym!)
        }
        
    }
    
    @IBAction func percentBtn(_ sender: UIButton) {
        if displayValue != 0{
        displayValue = Double(displayNumber_lbl.text!)! / 100
        displayNumber_lbl.text! = ("\(displayValue)")
        }
    }
    
    
    @IBAction func clearDisplay(_ sender: Any) {
        inputStack.removeAll()
        userActive = false
        self.digitHasDecimal = false
        operatorSym = nil
        displayValue = 0
    }
    
    func doCalculation( operation: (Double, Double) -> Double)  {
        displayValue = operation(inputStack.removeLast(), inputStack.removeLast())
        print("\(displayValue) ")
        inputStack.append(displayValue)
    }

}

