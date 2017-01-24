//
//  ViewController.swift
//  swiftCalc
//
//  Created by Lawrence Martin on 2017-01-17.
//  Copyright © 2017 mapd.centennial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentNum = Double()
    var operationResult = Double()
    var displayNum:Int = 0
    
    @IBOutlet weak var displayNumber_lbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //displayNumber_lbl.text = ("\(displayNum)")
    }

    @IBAction func numberInputHandler(_ sender: UIButton) {
        
        displayNumber_lbl.text = displayNumber_lbl.text! + sender.currentTitle!
    }
    

    @IBAction func clearDisplay(_ sender: Any) {
        displayNumber_lbl.text = ("\(displayNum)")
    }

}

