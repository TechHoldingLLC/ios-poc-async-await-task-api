//
//  ListViewController.swift
//  POCDemo
//
//  Created by DNREDDi on 25/01/23.
//

import UIKit

class ListViewController: UIViewController {
    var items: [String] = ["Task", "Individual Tasks", "Task.cancel", "Task.sleep", "Task.detached", "Task.yield", "async let & Task Group", "Refactoring Delegation Code"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = items[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        switch selectedItem {
        case "Task":
            self.performSegue(withIdentifier: "TaskViewController", sender: nil)
        case "Individual Tasks":
            self.performSegue(withIdentifier: "IndividualTasksViewController", sender: nil)
        case "Task.cancel":
            self.performSegue(withIdentifier: "CancelTaskViewController", sender: nil)
        case "Task.sleep":
            print("Task sleep()")
            self.performSegue(withIdentifier: "SleepViewController", sender: nil)
        case "Task.detached":
            print("Task.detached")
            self.performSegue(withIdentifier: "DetachedViewController", sender: nil)
        case "Task.yield":
            self.performSegue(withIdentifier: "YieldViewController", sender: nil)
            print("Task.yield")
        case "async let & Task Group":
            print("async let")
            self.performSegue(withIdentifier: "AsyncLetViewController", sender: nil)
        case "Async Sequence":
            print("Async Sequence")
            self.performSegue(withIdentifier: "AsyncSequenceViewController", sender: nil)
        case "Refactoring Delegation Code":
            print("Refactoring Delegation Code")
            self.performSegue(withIdentifier: "RefactorViewController", sender: nil)
        default:
            print("Not matched!")
        }
    }
}
