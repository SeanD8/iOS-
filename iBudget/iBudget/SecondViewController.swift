//
//  SecondViewController.swift
//  iBudget
//
//  Created by XCode Developer (iOS/MacOS) on 2016-11-07.
//  Copyright © 2016 DJS. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var income: UITextField!
    @IBOutlet weak var saveButton1: UIButton!
    
    @IBOutlet weak var saveButton2: UIButton!
    @IBOutlet weak var saveButton3: UIButton!
    @IBOutlet weak var saveButton4: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var exspense: UITextField!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var percent: UITextField!
    @IBOutlet weak var percentWarningLabel: UILabel!
    @IBOutlet weak var incomeWarningLabel: UILabel!
    @IBOutlet weak var expenseWarningLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton1.layer.cornerRadius = 10
        saveButton2.layer.cornerRadius = 10
        saveButton3.layer.cornerRadius = 10
        saveButton4.layer.cornerRadius = 10
        let savedData = SavedData()
        let income = savedData.getSavedIncome()
        let expense = savedData.getSavedExpense()
        let percent = savedData.getPercentSaved()
        
        label.text = "Current Monthly Income: $\(String(format:"%.2f",income))"
        label2.text = "Current Monthly Expenses: $\(String(format:"%.2f",expense))"
        label3.text = "%\(String(format:"%.0f",percent))"
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
     func getIncome () {
        let a:Double? = Double(income.text!)
        if let userInput = a{
            incomeWarningLabel.hidden = true
            label.text = "Current Monthly Income: $\(String(format:"%.2f",userInput))"
            let prefs = NSUserDefaults.standardUserDefaults()
            prefs.setDouble(userInput, forKey: "Income")
            updateBudget()
            income.text = ""
        }else{
            incomeWarningLabel.hidden = false
            income.text = ""
        }
    }
     func getExpense() {
        let a:Double? = Double(exspense.text!)
        if let userInput = a{
            expenseWarningLabel.hidden = true
            label2.text = "Current Monthly Expense: $\(String(format:"%.2f",userInput))"
            let prefs = NSUserDefaults.standardUserDefaults()
            prefs.setDouble(userInput, forKey: "Expense")
            updateBudget()
            exspense.text = ""
        }else{
            expenseWarningLabel.hidden = false
            exspense.text = ""
        }
    }
    func getPercent() {
        let a:Double? = Double(percent.text!)
     
        if let userInput = a{
            if(userInput > -0.00000000000001 && userInput < 100.00000000000001){
                percentWarningLabel.hidden = true
                label3.text = "\(String(format:"%.0f",userInput))%"
                let prefs = NSUserDefaults.standardUserDefaults()
                prefs.setDouble(userInput, forKey: "Percent")
                updateBudget()
                percent.text = ""
            }else{
                percentWarningLabel.hidden = false
                percent.text = ""
            }
        }else{
            percentWarningLabel.hidden = false
            percent.text = ""
        }
        
    }
    func resetData(){
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setDouble(0.0, forKey: "Income")
        prefs.setDouble(0.0, forKey: "Expense")
        prefs.setDouble(0.0, forKey: "Percent")
        prefs.setDouble(0.0, forKey: "Spending Money")
        prefs.setDouble(0.0, forKey: "Remaining Balance")
        prefs.setDouble(0.0, forKey: "Saved to Date")
        prefs.setDouble(0.0, forKey: "Total Spent")
        prefs.setObject(nil, forKey: "Date")
        prefs.setDouble(0.0, forKey: "Time Passed")
        label.text = "Current Monthly Income: $\(0.00)"
        label2.text = "Current Monthly Income: $\(0.00)"
        label3.text = "Current Monthly Income: $\(0.00)"
        label3.text = "\(0)%"
    }
    func updateBudget(){
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setBool(true, forKey: "Update")
    }

    @IBAction func save(sender: UIButton) {
        getIncome()
    }

    @IBAction func save2(sender: UIButton) {
        getExpense()
    }
    
    @IBAction func save3(sender: UIButton) {
        getPercent()
    }
    @IBAction func clear(sender: UIButton) {
        resetData()
    }
    
}

