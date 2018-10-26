//
//  MultiThreadingOperationQueue.swift
//  MutithreadingAndLocking
//
//  Created by saket bhushan on 26/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import Foundation

class MultiThreadingOperationQueue {
    
    let url = "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg"
    
    func downloadImageInOperation() {
        let operationQueue = OperationQueue()
        for i in 1 ... 5 {
            operationQueue.addOperation {
                let url = URL(string: self.url)
                _ = try? Data(contentsOf: url!)
                print("image downloaded \(i)")
            }
        }
        operationQueue.maxConcurrentOperationCount = 1
        print("no of queue :: \(operationQueue.maxConcurrentOperationCount)")
//        operationQueue.waitUntilAllOperationsAreFinished() // This is similiar to SYNC in dispatch => it will freeze the app.
    }
    
}
