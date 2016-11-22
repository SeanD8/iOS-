//
//  SavedData.swift
//  iBudget
//
//  Created by iOS Developer on 2016-11-19.
//  Copyright © 2016 DJS. All rights reserved.
//

import Foundation
class SavedData {
    
    func getSavedIncome() -> Double{
        let prefs = NSUserDefaults.standardUserDefaults()
        let income = prefs.doubleForKey("Income")
        return income
    }
    func getSavedExpense() -> Double{
        let prefs = NSUserDefaults.standardUserDefaults()
        let income = prefs.doubleForKey("Expense")
        return income
    }
    func getMonthlySavings() -> Double{
        let prefs = NSUserDefaults.standardUserDefaults()
        let income = prefs.doubleForKey("Income")
        let expense = prefs.doubleForKey("Expense")
        let saved = income - expense
        return saved
    }
    func getYearlySaved() -> Double{
        let saved = getMonthlySavings()
        let yearlySaved = saved*12
        return yearlySaved
    }
    func getPercentSaved() -> Double{
        let prefs = NSUserDefaults.standardUserDefaults()
        let income = prefs.doubleForKey("Percent")
        return income
    }
}