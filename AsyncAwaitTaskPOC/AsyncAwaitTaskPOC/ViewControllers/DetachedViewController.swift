//
//  DetachViewController.swift
//  POCDemo
//
//  Created by DNREDDi on 31/01/23.
//

import UIKit

class DetachedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func detachMethod() {
        Task(priority: .background) {
            print("I am Background on \(Thread.current) with Priority: \(Task.currentPriority)")
            
            Task {
                print("I am Child on \(Thread.current) with Priority: \(Task.currentPriority)")
            }
            
            Task.detached {
                print("I am Detached on \(Thread.current) with Priority: \(Task.currentPriority)")
            }
        }
    }
}
