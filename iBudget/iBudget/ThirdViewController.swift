//
//  ThirdViewController.swift
//  iBudget
//
//  Created by XCode Developer (iOS/MacOS) on 2016-11-07.
//  Copyright © 2016 DJS. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    let data = SavedData()
    
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expensesLabel: UILabel!
    @IBOutlet weak var netIncomeLabel: UILabel!
    @IBOutlet weak var yearlyLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var savingsToDate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        incomeLabel.layer.cornerRadius = 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        loadData()
    }
    
    func loadData(){
        incomeLabel.text = "$\(String(format:"%.2f",data.getSavedIncome()))"
        expensesLabel.text = "$\(String(format:"%.2f",data.getSavedExpense()))"
        netIncomeLabel.text = "$\(String(format:"%.2f",data.getMonthlySavings()))"
        yearlyLabel.text = "$\(String(format:"%.2f",data.getYearlySaved()))"
        savingsToDate.text = "$\(String(format:"%.2f",data.getSavedToDate()))"
    }
}

