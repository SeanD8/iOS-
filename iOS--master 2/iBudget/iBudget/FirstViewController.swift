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
    @IBOutlet weak var remainingLabel: UILabel!
    
    @IBOutlet weak var incomeButton: UIButton!
    @IBOutlet weak var expenseButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        expenseButton.layer.cornerRadius = 10
        incomeButton.layer.cornerRadius = 10
        remainingLabel.layer.masksToBounds = true
        remainingLabel.layer.cornerRadius = 100
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}