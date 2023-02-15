//
//  IndividualTasksViewController.swift
//  POCDemo
//
//  Created by DNREDDi on 25/01/23.
//

import UIKit

class IndividualTasksViewController: UIViewController {
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        imageView1.setBorder()
        imageView2.setBorder()
        imageView3.setBorder()
        imageView4.setBorder()
    }
    
    @IBAction func runIndependently() {
        imageView1.reset()
        imageView2.reset()
        imageView3.reset()
        imageView4.reset()
        
        Task {
            let image = try? await HTTPClient.shared.loadImage(number: 1)
            print("Image Loaded - 1")
            imageView1.image = image
        }
        
        Task {
            let image = try? await HTTPClient.shared.loadImage(number: 2)
            print("Image Loaded - 2")
            imageView2.image = image
        }
        
        Task {
            let image = try? await HTTPClient.shared.loadImage(number: 3)
            print("Image Loaded - 3")
            imageView3.image = image
        }
        
        Task {
            let image = try? await HTTPClient.shared.loadImage(number: 4)
            print("Image Loaded - 4")
            imageView4.image = image
        }
    }
    
    @IBAction func runOneAfterAnother() { // Wrap dependent tasks
        imageView1.image = UIImage(named: "")
        imageView2.image = UIImage(named: "")
        imageView3.image = UIImage(named: "")
        imageView4.image = UIImage(named: "")
        
        Task {
            print("\(Task.currentPriority)")
            var image = try? await HTTPClient.shared.loadImage(number: 2)
            print("Image Loaded - 1")
            imageView1.image = image

            print("\(Task.currentPriority)")
            image = try? await HTTPClient.shared.loadImage(number: 3)
            print("Image Loaded - 2")
            imageView2.image = image

            image = try? await HTTPClient.shared.loadImage(number: 4)
            print("Image Loaded - 3")
            imageView3.image = image

            image = try? await HTTPClient.shared.loadImage(number: 5)
            print("Image Loaded - 4")
            imageView4.image = image
        }
    }
}

extension UIImageView {
    func setBorder() {
        self.reset()
        self.layer.cornerRadius = self.frame.self.height / 2
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 2.0
    }
    
    func reset() {
        self.image = UIImage(named: "Placeholder")
    }
}
