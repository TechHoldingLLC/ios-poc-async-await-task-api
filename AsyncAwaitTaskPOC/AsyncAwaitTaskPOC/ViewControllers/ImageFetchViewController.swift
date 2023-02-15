//
//  ImageFetchViewController.swift
//  POCDemo
//
//  Created by DNREDDi on 23/01/23.
//

import UIKit

class sd: UIViewController {

    var imageLoadTask: Task<UIImage, Error>? = nil
    
    @IBOutlet weak var imageView10: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func imageFetch() {
        
        imageLoadTask = Task {
            do {
                let image = try await HTTPClient.shared.loadImage(number: 10, delayFetch: 4)
                imageView10.image = image
                print("Image Fetched Succesfully")
                return image
            } catch {
                print(error)
            }
            return UIImage()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageLoadTask?.cancel()
    }
}
