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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let savedData = SavedData()
        let income = savedData.getSavedIncome()
        let expense = savedData.getSavedExpense()
        
        label.text = "Current Monthly Income: $\(income)"
        label2.text = "Current Monthly Income: $\(expense)"
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
     func getIncome () {
        let a:Int? = Int(income.text!)
        //let text: String = income.text!
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

    @IBAction func save(sender: UIButton) {
        getIncome()
    }

    @IBAction func save2(sender: UIButton) {
        getExpense()
    }
    
}

