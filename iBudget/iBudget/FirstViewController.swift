//
//  FirstViewController.swift
//  iBudget
//
//  Created by XCode Developer (iOS/MacOS) on 2016-11-07.
//  Copyright © 2016 DJS. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var incomeButton: UIButton!
    @IBOutlet weak var expenseButton: UIButton!
    @IBOutlet weak var remainingBudget: UILabel!
    @IBOutlet weak var expenseField: UITextField!
    @IBOutlet weak var incomeField: UITextField!
    
    
    let data = SavedData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        incomeButton.layer.cornerRadius = 10
        expenseButton.layer.cornerRadius = 10
        updateProgress()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let prefs = NSUserDefaults.standardUserDefaults()
        let incomeChanged = data.doIUpdate()
        if incomeChanged {
            let income = prefs.doubleForKey("Income")
            let expense = prefs.doubleForKey("Expense")
            let percent = prefs.doubleForKey("Percent")
            let net = income - expense
            let spendingMoney = net - (net*percent/100)
            prefs.setDouble(spendingMoney, forKey: "Spending Money")
            let totalSpent = prefs.doubleForKey("Total Spent")
            let remainingBalance = spendingMoney + totalSpent
            prefs.setDouble(remainingBalance, forKey: "Remaining Balance")
        }
        prefs.setBool(false, forKey: "Update")
        updateProgress()
    }
    
    func updateProgress(){
        let spendingMoney = data.getSpendingMoney()
        let remainingBalance = data.getRemainingBalance()
        let percentLeft = 1 - (Float((spendingMoney - remainingBalance)/spendingMoney))
        progressBar.setProgress(percentLeft, animated: true)
        remainingBudget.text = "$\(remainingBalance)"
        
    }
    
    func getIncome () {
        let a:Double? = Double(incomeField.text!)
        if let userInput = a{
            let prefs = NSUserDefaults.standardUserDefaults()
            var money = data.getRemainingBalance()
            money = money + userInput
            prefs.setDouble(money, forKey: "Remaining Balance")
            var total = prefs.doubleForKey("Total Spent")
            total = total + userInput
            prefs.setDouble(total, forKey: "Total Spent")
            updateProgress()
        }else{
            //label.text = "Please Enter a Number"
        }
    }
    
    func getExpense() {
        let a:Double? = Double(expenseField.text!)
        if let userInput = a{
            let prefs = NSUserDefaults.standardUserDefaults()
            var money = data.getRemainingBalance()
            money = money - userInput
            prefs.setDouble(money, forKey: "Remaining Balance")
            var total = prefs.doubleForKey("Total Spent")
            total = total - userInput
            prefs.setDouble(total, forKey: "Total Spent")
            updateProgress()
        }else{
            //label2.text = "Please Enter a Number"
        }
    }
    
    func resetSpendingMoney(){
        let netIncome = data.getMonthlySavings()
        let percent = data.getPercentSaved()
        let spendingMoney = netIncome * (percent/100)
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setDouble(spendingMoney, forKey: "Spending Money")
        prefs.setDouble(spendingMoney, forKey: "Remaining Balance")
        updateProgress()
    }
    @IBAction func addIncome(sender: UIButton) {
        getIncome()
    }
    
    @IBAction func addExpense(sender: UIButton) {
        getExpense()
    }
    
}

