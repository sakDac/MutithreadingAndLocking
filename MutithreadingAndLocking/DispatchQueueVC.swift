//
//  DispatchQueueVC.swift
//  MutithreadingAndLocking
//
//  Created by saket bhushan on 22/11/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit

class DispatchQueueVC: UIViewController {
    
    let url = "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg"
    
    // To do bunch of task in background and know the background task completion status
    let dispatchQueue = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.longRunningFunction()
    }

    func longRunningFunction() {
        let group = DispatchGroup()
        for i in 1 ... 5 {
            group.enter()
            let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
            dispatchQueue.async(group: group, qos: .background, flags: .barrier) {
                let url = URL(string: self.url)
                _ = try? Data(contentsOf: url!)
                print("image downloaded \(i)")
            }
                group.leave()
        }
        group.notify(queue: DispatchQueue.main, execute: {
            print("All task finished!")
        })
    }
    
    
    

}
