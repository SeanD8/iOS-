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
        checkDate()
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
        end = "2017-02-5"
        
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
    
    func updateSavings(){
        let prefs = NSUserDefaults.standardUserDefaults()
        let remainingBalance = prefs.doubleForKey("Remaining Balance")
        let monthlySavings = data.getMonthlySavings()
        var totalSaved = monthlySavings + remainingBalance
        totalSaved = totalSaved + data.getSavedToDate()
        prefs.setDouble(totalSaved, forKey: "Saved to Date")
        resetSpendingMoney()
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
        let netIncome = (data.getSavedIncome() - data.getSavedExpense()) - data.getMonthlySavings()
        let spendingMoney = netIncome
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setDouble(spendingMoney, forKey: "Spending Money")
        prefs.setDouble(spendingMoney, forKey: "Remaining Balance")
        prefs.setDouble(0.0, forKey: "Total Spent")
        updateProgress()
    }
    @IBAction func addIncome(sender: UIButton) {
        getIncome()
    }
    
    @IBAction func addExpense(sender: UIButton) {
        getExpense()
    }
    
}

