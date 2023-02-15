//
//  AsyncSequenceViewController.swift
//  POCDemo
//
//  Created by DNREDDi on 15/02/23.
//

import UIKit

class AsyncSequenceViewController: UIViewController {
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    let images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
