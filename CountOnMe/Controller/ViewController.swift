//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    
    var brainiac = Brainiac()
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
       
    }
    
    
    
    
    
   // View Life cycles
   override func viewDidLoad() {
       super.viewDidLoad()
       // Do any additional setup after loading the view.
   }
    
    
    

    @IBAction func tappedEqualButton(_ sender: UIButton) {
       
    }

}

