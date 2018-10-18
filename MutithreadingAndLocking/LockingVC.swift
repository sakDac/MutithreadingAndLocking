//
//  LockingVC.swift
//  Multithreading_N_Locking
//
//  Created by saket bhushan on 14/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit

/*
 Locking Ref(semaphore, locks, dispatch barrier, serial queue) and concurrency:- https://priteshrnandgaonkar.github.io/concurrency-with-swift-3/
 */

class LockingVC: UIViewController {

    
    var items = [Int]()
    
//1.    var semaphore = DispatchSemaphore(value: 1)
//2.    var lock = NSLock()
//3.   var concurrentQueue = DispatchQueue(label: "MyQueue", attributes: .concurrent)
//4.   using simple serial queue.
    
    
    //Producer:
    func add(num: Int) {
//        semaphore.wait(timeout: .distantFuture)
//        lock.lock()
//        concurrentQueue.async(flags: .barrier) { [weak self] in
//        }
        
        print("Add \(num)")
        self.items.append(num)
//        semaphore.signal()
//        lock.unlock()
    }
    
    //Consumer:
    func remove() {
//        semaphore.wait(timeout: .distantFuture)
//        lock.lock()
//        concurrentQueue.async(flags: .barrier){ [weak self] in
            guard !self.items.isEmpty else {
//            lock.unlock()
//            semaphore.signal()
            return
//        }
        
            let num = self.items.removeLast()
            print("Remove \(num)")
//        }
        
//        lock.unlock()
//        semaphore.signal()
    }
}
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dispatchQueue = DispatchQueue(label: "com.prit.TestGCD.DispatchQueue", attributes: .concurrent)
        
        for x in 0..<10 {
            dispatchQueue.async {
                self.add(num: x)
            }
        }
        
        for _ in 0..<10 {
            dispatchQueue.async {
                self.remove()
            }
        }
        
    }
}
