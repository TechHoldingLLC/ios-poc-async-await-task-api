//
//  RefactorViewController.swift
//  AsyncAwaitTaskPOC
//
//  Created by DNREDDi on 16/02/23.
//

import UIKit

protocol MyProtocol: AnyObject {
    func didSuccess(data: Int)
    func didFail(error: Error)
}

class RefactorViewController: UIViewController {
    
    let dataProvider = DataProvoder()
    var continuation: CheckedContinuation<Int, Error>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Delegate Refactoring"
        dataProvider.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func perform() {
        Task {
            let data = try await performDataFetch()
            print(data)
        }
    }
    
    func performDataFetch() async throws -> Int {
        return try await withCheckedThrowingContinuation({ continuation in
            self.continuation = continuation
            dataProvider.fetchInfo()
        })
    }
}

class DataProvoder {
    weak var delegate: MyProtocol? = nil
    
    func fetchInfo() {
        delegate?.didSuccess(data: Int.random(in: 1...10000))
    }
}

extension RefactorViewController: MyProtocol {
    func didSuccess(data: Int) {
        continuation?.resume(returning: data)
        continuation = nil
    }
    
    func didFail(error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
}



