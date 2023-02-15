//
//  SleepViewController.swift
//  POCDemo
//
//  Created by DNREDDi on 30/01/23.
//

import UIKit

class SleepViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        profileImageView.setBorder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func fetchProfileInfo() {
        profileImageView.reset()
            loadingIndicator.startAnimating()
        Task {
            try await Task.sleep(nanoseconds: 3_000_000_000)
            let user = try await HTTPClient.shared.delayUserFetchAPI(delay: 0)
            updateUI(user: user!)
            let profilePic = try await HTTPClient.shared.fetchImage(endPoint: user?.avatar ?? "")
            profileImageView.image = profilePic
            loadingIndicator.stopAnimating()
            print("Profile Fetched!")
        }
    }
    
    func updateUI(user: User) {
        firstNameLabel.text = user.first_name
        lastNameLabel.text = user.last_name
        emailLabel.text = user.email
    }
}
