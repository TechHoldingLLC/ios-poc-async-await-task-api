//
//  TaskViewController.swift
//  POCDemo
//
//  Created by DNREDDi on 25/01/23.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        imageView.setBorder()
    }
    
    @IBAction func fetchImage() {
        print("Before Task")
        Task {
            print("Start Task")
            print("I am in TASK \(Thread.current)")
            
            loadingIndicator.startAnimating()
            let image = try? await HTTPClient.shared.loadImage(number: 1)
            
            print("I am in TASK \(Thread.current)")
            
            loadingIndicator.stopAnimating()
            imageView.image = image            
            print("End Task")
        }
        print("After Task")
    }
}
