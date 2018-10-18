//
//  MultiThreadingVC.swift
//  Multithreading_N_Locking
//
//  Created by saket bhushan on 14/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit
/*
 Multi Threading REF :- https://www.raywenderlich.com/5370-grand-central-dispatch-tutorial-for-swift-4-part-1-2
 video ref:- https://www.youtube.com/watch?v=YhZahnTiA8U
 */



class MultiThreadingVC: UIViewController {
    
    var list = ["Aaran", "Aaren", "Aarez", "Aarman", "Aaron", "Aaron-James", "Aarron", "Aaryan", "Aaryn", "Aayan", "Aazaan", "Abaan", "Abbas", "Abdallah", "Abdalroof", "Abdihakim", "Abdirahman", "Abdisalam", "Abdul", "Abdul-Aziz", "Abdulbasir", "Abdulkadir", "Abdulkarem", "Abdulkhader", "Abdullah", "Abdul-Majeed", "Abdulmalik", "Abdul-Rehman", "Ab","Kaydn", "Kaydyn", "Kaydyne", "Kayleb", "Kaylem", "Kaylum", "Kayne", "Kaywan", "Kealan", "Kealon", "Kean", "Keane", "Kearney", "Keatin", "Keaton", "Keavan", "Kea"]
    
    let url = "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg"
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBAction func Serial_Sync(_ sender: UIButton) {
        self.toggleOnButtonSelection(sender: sender)
        let queue = DispatchQueue(label: "mySerialQueue")
        for i in 1 ... 5 {
            queue.sync {
                let url = URL(string: self.url)
                _ = try? Data(contentsOf: url!)
                print("image downloaded \(i)")
            }
            print("Loop count :: \(i)")
        }
    }
    
    @IBAction func Serial_Async(_ sender: UIButton) {
        self.toggleOnButtonSelection(sender: sender)
        let queue = DispatchQueue(label: "mySerialQueue")
        for i in 1 ... 5 {
            queue.async { // DispatchQueue.global(qos: .utility).async if you put this line in loop this create seperate threads each time.
                let url = URL(string: self.url)
                _ = try? Data(contentsOf: url!)
                print("image downloaded \(i)")
            }
            print("Loop count :: \(i)")
        }
    }
    
    
    @IBAction func concurrent_Sync(_ sender: UIButton) {
        self.toggleOnButtonSelection(sender: sender)
       let concurrentQueue = DispatchQueue(label: "concurrent_Sync_Queue", attributes: .concurrent)
        for i in 1 ... 5 {
            concurrentQueue.sync {
                let url = URL(string: self.url)
                _ = try? Data(contentsOf: url!)
                print("image downloaded \(i)")
            }
            print("Loop count :: \(i)")
        }
    }
    
    
    @IBAction func Concurrent_Async(_ sender: UIButton) {
        self.toggleOnButtonSelection(sender: sender)
        let concurrentQueue = DispatchQueue(label: "concurrent_Sync_Queue", qos: .utility, attributes: .concurrent)
        for i in 1 ... 5 {
            concurrentQueue.async {
                let url = URL(string: self.url)
                _ = try? Data(contentsOf: url!)
                print("image downloaded \(i)")
            }
            print("Loop count :: \(i)")
        }
    }
    
    
    /// This method is added to show how you will work with sync without freezing the ui.
    @IBAction func Sync_With_Async(_ sender: UIButton) {
        self.toggleOnButtonSelection(sender: sender)
        let queue = DispatchQueue(label: "concurrent_Sync_Queue")
        queue.async {
            let concurrentQueue = DispatchQueue(label: "concurrent_Sync_Queue", attributes: .concurrent)
            for i in 1 ... 5 {
                concurrentQueue.sync {
                    let url = URL(string: self.url)
                    _ = try? Data(contentsOf: url!)
                    print("image downloaded \(i)")
                }
                print("Loop count :: \(i)")
            }
        }
    }
    
    
    func toggleOnButtonSelection(sender: UIButton) {
        self.buttonCollection.forEach {$0.backgroundColor = UIColor.white}
        sender.backgroundColor = UIColor.red.withAlphaComponent(0.5)
    }
}

extension MultiThreadingVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
