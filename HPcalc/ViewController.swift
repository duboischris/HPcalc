//
//  ViewController.swift
//  HPcalc
//
//  Created by Chris DuBois on 10/1/15.
//  Copyright © 2015 Chris DuBois. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var stackDisplay: UILabel!

    var userIsInTheMiddleOfTypingNumber = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }
    }

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber {
            enter()
        }
        switch operation {
            case "✕":   performOperation { $0 * $1 }
            case "÷":   performOperation { $1 / $0 }
            case "+":   performOperation { $0 + $1 }
            case "-":   performOperation { $1 - $0 }
            case "√":   performOperation { sqrt($0) }
//        TODO
            case "💩":  print("operandStack = \(operandStack)")
            case "AC":  operandStack.removeAll()
                print("operandStack = \(operandStack)")
                display.text = "0.0"
        default: break
        }

    }

    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }

    }

    @nonobjc    // Required becuase OBJ-C doesn't support func overloading, but SWIFT does.
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }

    }
    var operandStack = Array<Double>()

    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        operandStack.append(displayValue)
        stackDisplay.text = "\(operandStack)"
        print("operandStack = \(operandStack)")
    }

    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
        }
    }
}