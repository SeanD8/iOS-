//
//  SavedData.swift
//  iBudget
//
//  Created by iOS Developer on 2016-11-19.
//  Copyright © 2016 DJS. All rights reserved.
//

import Foundation
class SavedData {
    func getSavedIncome() -> Int{
        
        let prefs = NSUserDefaults.standardUserDefaults()
        let income = prefs.integerForKey("Income")
        return income
        
    }
    func getSavedExpense() -> Int{
        let prefs = NSUserDefaults.standardUserDefaults()
        let income = prefs.integerForKey("Expense")
        return income
    }
    func getMonthlySavings() -> Int{
        let prefs = NSUserDefaults.standardUserDefaults()
        let income = prefs.integerForKey("Income")
        let expense = prefs.integerForKey("Expense")
        let saved = income - expense
        return saved
    }
    func getYearlySaved() -> Int{
        let saved = getMonthlySavings()
        let yearlySaved = saved*12
        return yearlySaved
    }
    
}