//
//  MultiThreadingOperationQueue.swift
//  MutithreadingAndLocking
//
//  Created by saket bhushan on 26/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import Foundation

let imgUrl = "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg"

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
        operationQueue.waitUntilAllOperationsAreFinished() // This is similiar to SYNC in dispatch => it will freeze the app.
    }
    
    
    func downloadImageInOperationUsingCustomOperations() {
        
        let operationQueue = OperationQueue()

        let operationFirst = OperationFirst()

        let operationSecond = OperationSecond()
        operationSecond.addDependency(operationFirst)

        operationQueue.addOperations([operationFirst, operationSecond], waitUntilFinished: false)
        
    }
    
}


class OperationFirst: Operation {
    
    override func main() {
        for i in 1 ... 5 {
                let url = URL(string: imgUrl)
                _ = try? Data(contentsOf: url!)
            print("image downloaded : operation one : \(i)")
        }
    }
}

class OperationSecond: Operation {
    
    override func main() {
        for i in 1 ... 5 {
            let url = URL(string: imgUrl)
            _ = try? Data(contentsOf: url!)
            print("image downloaded : operation Two : \(i)")
        }
    }
    
}
