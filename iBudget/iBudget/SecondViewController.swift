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
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var exspense: UITextField!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var percent: UITextField!
    @IBOutlet weak var percentWarningLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let savedData = SavedData()
        let income = savedData.getSavedIncome()
        let expense = savedData.getSavedExpense()
        let percent = savedData.getPercentSaved()
        
        label.text = "Current Monthly Income: $\(income)"
        label2.text = "Current Monthly Expenses: $\(expense)"
        label3.text = "%\(percent)"
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
     func getIncome () {
        let a:Double? = Double(income.text!)
        if let userInput = a{
            label.text = "Current Monthly Income: $\(userInput)"
            let prefs = NSUserDefaults.standardUserDefaults()
            prefs.setDouble(userInput, forKey: "Income")
            updateBudget()
        }else{
            label.text = "Please Enter a Number"
        }
    }
     func getExpense() {
        let a:Double? = Double(exspense.text!)
        if let userInput = a{
            label2.text = "Current Monthly Expense: $\(userInput)"
            let prefs = NSUserDefaults.standardUserDefaults()
            prefs.setDouble(userInput, forKey: "Expense")
            updateBudget()
        }else{
            label2.text = "Please Enter a Number"
        }
    }
    func getPercent() {
        let a:Double? = Double(percent.text!)
     
        if let userInput = a{
            if(userInput > -0.00000000000001 && userInput < 100.00000000000001){
                percentWarningLabel.hidden = true
                label3.text = "\(userInput)%"
                let prefs = NSUserDefaults.standardUserDefaults()
                prefs.setDouble(userInput, forKey: "Percent")
                updateBudget()
            }else{
                percentWarningLabel.hidden = false
            }
        }else{
            percentWarningLabel.hidden = false
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

