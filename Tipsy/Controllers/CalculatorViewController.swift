//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var zeroPctButton: UIButton!
    
    var tipPct = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResultString = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        let pctButtons: [UIButton] = [zeroPctButton, tenPctButton, twentyPctButton]
        for button in pctButtons{
            if sender.currentTitle == button.currentTitle{
                button.isSelected = true
            }
            else{
                button.isSelected = false
            }
        }
        
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        tipPct = buttonTitleAsANumber / 100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        numberOfPeople = Int(sender.value)
        splitNumberLabel.text = String(numberOfPeople)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text!
        if bill != ""{
            billTotal = Double(bill)!
            let result = (billTotal * (1 + tipPct)) / Double(numberOfPeople)
            finalResultString = String(format: "%.2f", result)
            
        }
        
        self.performSegue(withIdentifier: "goToResultsView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResultsView"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = finalResultString
            destinationVC.tipPct = Int(tipPct * 100)
            destinationVC.split = numberOfPeople
        }
        
    }
    
}

