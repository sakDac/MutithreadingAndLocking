//
//  ViewController.swift
//  Multithreading_N_Locking
//
//  Created by saket bhushan on 13/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit
class MainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    @IBAction func click(_ sender: UIButton) {
        
        print("  click working...")
        
    }
    
    
    @IBAction func operationQueue(_ sender: UIButton) {
        MultiThreadingOperationQueue().downloadImageInOperation()
    }
    
}

