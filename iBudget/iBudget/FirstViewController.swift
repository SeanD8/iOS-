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
    
    @IBOutlet weak var incomeWarningLabel: UILabel!
    
    @IBOutlet weak var expenseWarningLabel: UILabel!
    let data = SavedData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        incomeButton.layer.cornerRadius = 10
        expenseButton.layer.cornerRadius = 10
        checkDate()
        updateProgress()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //used to refresh page on other elements change
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
    //checks the date to see if a month has passed
    func checkDate() {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components1 = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let year =  components1.year
        let month = components1.month
        let day = components1.day
        var end = "\(year)-\(month)-\(day)"
        
        let prefs = NSUserDefaults.standardUserDefaults()
        let start = prefs.stringForKey("Date")
        //end = "2016-12-31"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if start != nil {
            let startDate:NSDate = dateFormatter.dateFromString(start!)!
            let endDate:NSDate = dateFormatter.dateFromString(end)!
            
            let cal = NSCalendar.currentCalendar()
        
            let unit:NSCalendarUnit = .Day
            let daysPassed = cal.components(unit, fromDate: startDate, toDate: endDate, options: [])
            let timePassedDouble = prefs.doubleForKey("Time Passed")
            var totalTime = Double(daysPassed.day) + timePassedDouble
            
            let i = 30.4375
            while (i < totalTime) {
                totalTime = totalTime - 30.4375
                updateSavings()
            }
            prefs.setDouble(totalTime, forKey: "Time Passed")
        }
        prefs.setObject(end, forKey: "Date")
        
        
        
    }
    
    //update savings in defaults on change
    func updateSavings(){
        let prefs = NSUserDefaults.standardUserDefaults()
        let remainingBalance = prefs.doubleForKey("Remaining Balance")
        let monthlySavings = data.getMonthlySavings()
        var totalSaved = monthlySavings + remainingBalance
        totalSaved = totalSaved + data.getSavedToDate()
        prefs.setDouble(totalSaved, forKey: "Saved to Date")
        resetSpendingMoney()
    }
    //update progress bar depending on stored info
    func updateProgress(){
        let spendingMoney = data.getSpendingMoney()
        let remainingBalance = data.getRemainingBalance()
        var percentLeft: Float
        if spendingMoney >= 0 {
            percentLeft = 1 - (Float((spendingMoney - remainingBalance)/spendingMoney))
        } else {
            percentLeft = 0.0
        }
        progressBar.setProgress(percentLeft, animated: true)
        remainingBudget.text = "$\(String(format:"%.2f",remainingBalance))"
        
    }
    //get the income that was saved in defaults
    func getIncome () {
        let a:Double? = Double(incomeField.text!)
        if let userInput = a{
            incomeWarningLabel.hidden = true
            let prefs = NSUserDefaults.standardUserDefaults()
            var money = data.getRemainingBalance()
            money = money + userInput
            prefs.setDouble(money, forKey: "Remaining Balance")
            var total = prefs.doubleForKey("Total Spent")
            total = total + userInput
            prefs.setDouble(total, forKey: "Total Spent")
            updateProgress()
            incomeField.text = ""
        }else{
            incomeField.text = ""
            incomeWarningLabel.hidden = false
        }
    }
    //get expense saved on defaults
    func getExpense() {
        let a:Double? = Double(expenseField.text!)
        if let userInput = a{
            expenseWarningLabel.hidden = true
            let prefs = NSUserDefaults.standardUserDefaults()
            var money = data.getRemainingBalance()
            money = money - userInput
            prefs.setDouble(money, forKey: "Remaining Balance")
            var total = prefs.doubleForKey("Total Spent")
            total = total - userInput
            prefs.setDouble(total, forKey: "Total Spent")
            updateProgress()
            expenseField.text = ""
        }else{
            expenseField.text = ""
            expenseWarningLabel.hidden = false
        }
    }
    //reset spending money and progress bar
    func resetSpendingMoney(){
        var netIncome = (data.getSavedIncome() - data.getSavedExpense()) - data.getMonthlySavings()
        if netIncome <= 0 {
            netIncome = data.getSavedIncome() - data.getSavedExpense()
        }
        let spendingMoney = netIncome
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setDouble(spendingMoney, forKey: "Spending Money")
        prefs.setDouble(spendingMoney, forKey: "Remaining Balance")
        prefs.setDouble(0.0, forKey: "Total Spent")
        updateProgress()
    }
    //get income
    @IBAction func addIncome(sender: UIButton) {
        getIncome()
    }
    //get expense
    @IBAction func addExpense(sender: UIButton) {
        getExpense()
    }
    
}

