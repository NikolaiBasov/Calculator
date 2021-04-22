//
//  ViewController.swift
//  Calculator
//
//  Created by Николай Басов on 20.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet var numberButtons: [UIButton]!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var plusminusButton: UIButton!
    @IBOutlet weak var percentBatton: UIButton!
    
    @IBOutlet weak var equalsButton: UIButton!
    @IBOutlet weak var additionalButton: UIButton!
    @IBOutlet weak var subtractionButton: UIButton!
    @IBOutlet weak var multiplicationButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    
    @IBOutlet weak var numberLable: UILabel!
    
    //MARK: - Vars
    
    var numberOnScreen: Double = 0
    var previousNumber: Double = 0
    var isOperatorSelected: Bool = false
    var operation = 0
    var result: Double = 0
    var firstNumberInIndex: Bool = false
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in allButtons {
            button.layer.cornerRadius = 40
            button.addTarget(self, action: #selector(configureButtons(sender:)), for: .touchUpInside)
        }
        numberLable.adjustsFontSizeToFitWidth = true
    }
    
    //MARK: - Functions
    
    func checkIfInt(result: Double) {
        let isInteger = floor(result) == result
        if isInteger {
            if result >= Double(Int.max) || result <= Double(Int.min) {
                numberLable.text = "Error"
            } else {
                numberLable.text = String(Int(result))
            }
        } else {
            numberLable.text = String(round(10000 * result) / 10000)
        }
    }

    @objc func configureButtons(sender: UIButton) {
        switch sender.tag {
        case 0, 1, 2, 3, 4, 5, 6, 7, 8, 9: // numbers
            if isOperatorSelected {
                if firstNumberInIndex {
                numberLable.text = numberLable.text! + String(sender.tag)
                numberOnScreen = Double(numberLable.text!)!
            } else {
                numberLable.text = ""
                numberLable.text = String(sender.tag)
                numberOnScreen = Double(numberLable.text!)!
                firstNumberInIndex = true
            }
            } else {
                if numberLable.text == "0" {
                    numberLable.text = String(sender.tag)
                    numberOnScreen = Double(numberLable.text!)!
                } else if numberLable.text == "-0" {
                    numberLable.text = "-" + String(sender.tag)
                    numberOnScreen = Double(numberLable.text!)!
                } else if numberLable.text != "0" || numberLable.text != "-0" {
                    numberLable.text = numberLable.text! + String(sender.tag)
                    numberOnScreen = Double(numberLable.text!)!
                }
            }
        case 10: // =
            isOperatorSelected = false
            switch operation {
            case 11: // add
                result += numberOnScreen
                checkIfInt(result: result)
            case 12: // subtract
                result -= numberOnScreen
                checkIfInt(result: result)
            case 13: // multiply
                result *= numberOnScreen
                checkIfInt(result: result)
            case 14: // divide
                result /= numberOnScreen
                checkIfInt(result: result)
            default:
                break
            }
            
        case 11, 12 ,13, 14: // +, -, x, /
            result = Double(numberLable.text!)!
            numberOnScreen = Double(numberLable.text!)!
            isOperatorSelected = true
            firstNumberInIndex = false
            operation = sender.tag
        case 15: // AC
            isOperatorSelected = false
            operation = 0
            numberOnScreen = 0
            result = 0
            numberLable.text = "0"
            firstNumberInIndex = false
        case 16: // +/-
            if (numberLable.text?.contains("-"))! {
                var string = numberLable.text
                string!.remove(at: string!.startIndex)
                numberLable.text = string
            } else {
                var string = numberLable.text
                string!.insert("-", at: string!.startIndex)
                numberLable.text = string
            }
        case 17: // %
            let numberPercentage = String(Double(numberLable.text!)! / 100)
            numberLable.text = numberPercentage
            numberOnScreen = Double(numberLable.text!)!
        case 18: // .
            if !(numberLable.text?.contains("."))! {
                numberLable.text = numberLable.text! + "."
            }
        default:
            break
        }
    }
}

