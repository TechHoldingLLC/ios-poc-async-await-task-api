//
//  AsyncLetViewController.swift
//  POCDemo
//
//  Created by DNREDDi on 27/01/23.
//

import UIKit

class AsyncLetViewController: UIViewController {
    
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
    
    
    @IBAction func performWithNonAsyncLet() {
        // Resetting the image with placeholder
        imageView1.reset()
        imageView2.reset()
        imageView3.reset()
        imageView4.reset()
        loadingIndicator.startAnimating()
        Task {
            let image1 = try await HTTPClient.shared.loadImage(number: 1)
            imageView1.image = image1
            let image2 = try await HTTPClient.shared.loadImage(number: 2)
            imageView2.image = image2
            
            let image3 = try await HTTPClient.shared.loadImage(number: 3)
            imageView3.image = image3
            
            let image4 = try await HTTPClient.shared.loadImage(number: 4)
            imageView4.image = image4
            
            loadingIndicator.stopAnimating()            
        }
    }
    
    
    @IBAction func performWithAsyncLet() {
        // Resetting the image with placeholder
        imageView1.reset()
        imageView2.reset()
        imageView3.reset()
        imageView4.reset()
        loadingIndicator.startAnimating()
        Task {
            async let image1 = HTTPClient.shared.loadImage(number: 1)
            async let image2 = HTTPClient.shared.loadImage(number: 2)
            async let image3 = HTTPClient.shared.loadImage(number: 3)
            async let image4 = HTTPClient.shared.loadImage(number: 4)
            
            let images =  [try await image1, try await image2, try await image3, try await image4]
            loadingIndicator.stopAnimating()
            imageView1.image = images[0]
            imageView2.image = images[1]
            imageView3.image = images[2]
            imageView4.image = images[3]
        }
    }
    
    @IBAction func performWithTaskGroup() { // Wrap dependent tasks
        imageView1.reset()
        imageView2.reset()
        imageView3.reset()
        imageView4.reset()
        loadingIndicator.startAnimating()
        let viewModel = ViewModel()
        Task {
            let images = try await viewModel.fetchImagesWithTaskGroup()
            loadingIndicator.stopAnimating()
            imageView1.image = images[0]
            imageView2.image = images[1]
            imageView3.image = images[2]
            imageView4.image = images[3]
        }
    }
}

class ViewModel {
    
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        
        return try await withThrowingTaskGroup(of: UIImage.self) { group -> [UIImage] in
            group.addTask(operation: {
                try await HTTPClient.shared.loadImage(number: 1)
            })
            
            group.addTask(operation: {
                try await HTTPClient.shared.loadImage(number: 2)
            })
            
            group.addTask(operation: {
                try await HTTPClient.shared.loadImage(number: 3)
            })
            
            group.addTask(operation: {
                try await HTTPClient.shared.loadImage(number: 4)
            })
            
            var images: [UIImage] = []
            
            for try await image in group {
                images.append(image)
            }
            return images
        }
    }
}
