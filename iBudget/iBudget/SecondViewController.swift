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
        let a:Int? = Int(income.text!)
        if let userInput = a{
            label.text = "Current Monthly Income: $\(userInput)"
            let prefs = NSUserDefaults.standardUserDefaults()
            prefs.setInteger(userInput, forKey: "Income")
        }else{
            label.text = "Please Enter a Number"
        }
    }
     func getExpense() {
        
        let a:Int? = Int(exspense.text!)
        
        if let userInput = a{
            label2.text = "Current Monthly Expense: $\(userInput)"
            let prefs = NSUserDefaults.standardUserDefaults()
            prefs.setInteger(userInput, forKey: "Expense")
        }else{
            label2.text = "Please Enter a Number"
        }
    }
    func getPercent() {
        let a:Int? = Int(percent.text!)
        
        if let userInput = a{
            label3.text = "\(userInput)%"
            let prefs = NSUserDefaults.standardUserDefaults()
            prefs.setInteger(userInput, forKey: "Percent")
        }else{
            //label3.text = "Please Enter a Number"
        }
    }

    @IBAction func save(sender: UIButton) {
        getIncome()
    }

    @IBAction func save2(sender: UIButton) {
        getExpense()
    }
    
    @IBAction func save3(sender: UIButton) {
        getPercent()
    }//HELLO
}

