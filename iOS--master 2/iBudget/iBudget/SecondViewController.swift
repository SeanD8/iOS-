//
//  SecondViewController.swift
//  iBudget
//
//  Created by XCode Developer (iOS/MacOS) on 2016-11-07.
//  Copyright © 2016 DJS. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var income: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var exspense: UITextField!
    
    @IBOutlet weak var label2: UILabel!
    
     func getIncome () {
        let a:Int? = Int(income.text!)
        //let text: String = income.text!
        
        
    
        
        label.text = "\(a!)"
    }
     func getExpense() {
        let text: String = exspense.text!
        
        
        
        label2.text = "\(text)"
    }

    @IBAction func save(sender: UIButton) {
        getIncome()
    }

    @IBAction func save2(sender: UIButton) {
        getExpense()
    }
    
}

