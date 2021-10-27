//
//  ViewController.swift
//  GCD
//
//  Created by Luat on 10/27/21.
//

import UIKit

/// GCD: Grand Central Dispatch
/// Dev manage the queues, FIFO

/// Main queue Vs Global queue
/// Main:
/// - serial, ALL UI
/// - update has to be on the main queue/thread
/// - only 1 main queue

/// Global
/// - multiple global queue
/// - concurrent

/// Serial Vs Concurrent
/// Serial: 1st tasks has to finish BEFORE 2nd tasks starts
/// Concurrent: Multiple tasks can be started

/// Async vs Sync
/// Sync: that task has to finish before the caller can continue
/// Async: gives controll back to the current context without pausing

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DispatchQueue.main.async {
//            self.view.backgroundColor = .red
//        }
        
//        DispatchQueue.global().asyncAfter(deadline: .now() + 4) {
//            self.startMain(label: "Task C")
//            self.startMain(label: "Task D")
//            self.startGlobal(label: "Task A") // pause at line 42
//            print("after AAAA")
//            self.startGlobal(label: "Task B")
//            self.startMain(label: "Task E")
//        }
        groups()
        
    }
    
    func startMain(label: String) {
        DispatchQueue.main.async {
            for num in 1...100 {
                print("\(label) Num: \(num)")
            }
        }
    }
    
    func startGlobal(label: String) {
        /// Highest priority global queue
        DispatchQueue.global(qos: .userInteractive).sync {
            for num in 1...100 {
                print("\(label) Num: \(num)")
            }
        }
    }
    
    func startMidGlobal(label: String) {
        /// Highest priority global queue
        DispatchQueue.global(qos: .userInitiated).async {
            for num in 1...100 {
                print("\(label) Num: \(num)")
            }
        }
    }
    
    func startMidLowGlobal(label: String) {
        /// Highest priority global queue
        DispatchQueue.global(qos: .background).async {
            for num in 1...100 {
                print("\(label) Num: \(num)")
            }
        }
    }
    
    func startLowGlobal(label: String) {
        /// Highest priority global queue
        DispatchQueue.global(qos: .utility).async {
            for num in 1...100 {
                print("\(label) Num: \(num)")
            }
        }
    }

    

    func customQueue() {
        let myQueue = DispatchQueue(label: "myQueue.serial")
        let myConcurQueue = DispatchQueue(label: "myQueue.concurrent", attributes: .concurrent)
        
        myQueue.async {
            print("code")
        }
    }
    
    let urlOne = URL(string: "https://www.google.com")!
    let urlTwo = URL(string: "https://www.amazon.com")!
    let urlThree = URL(string: "https://www.youtube.com")!
    
    let group = DispatchGroup()
    
    func groups() {
        
        group.enter()
        group.enter()
        
        print("starting Task One")
        let taskOne = URLSession.shared.dataTask(with: urlOne) { d, r, e in
            self.group.leave()
            print("finished Task One")

        }
        

        print("starting Task Two")
        let taskTwo = URLSession.shared.dataTask(with: urlTwo) { d, r, e in
            self.group.leave()
            print("finished Task Two")

        }
        
        group.enter()
        print("starting Task three")
        let taskThree = URLSession.shared.dataTask(with: urlThree) { d, r, e in
            self.group.leave()
            print("finished Task three")
        }
        
        taskOne.resume()
        taskTwo.resume()
        taskThree.resume()
//        taskTwo.cancel()
//
        group.notify(queue: .main) {
            self.updateUI()
        }
    }
    
    func updateUI() {
        /// reload table view
        /// update labels
        print("update ui called")

    }
}

