//
//  YieldViewController.swift
//  POCDemo
//
//  Created by DNREDDi on 30/01/23.
//

import UIKit

class YieldViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func fetchProfileInfo() {
                
        Task {
            for i in 1...10000 {
                print("+++++++++++ \(i)")
                if i % 1000 == 0 {
                    await Task.yield()
                }
            }
        }
                
        Task {
            for i in 1...1000 {
                print("---------- \(i)")
            }
        }
    }
}
