//
//  CancelTaskViewController.swift
//  POCDemo
//
//  Created by DNREDDi on 25/01/23.
//

import UIKit

class CancelTaskViewController: UIViewController {
    
    var profileFetchTask: Task<Any?, Error>?
    
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
        
        // Way 1
        if !(profileFetchTask?.isCancelled ?? false) {
            profileFetchTask?.cancel()
        }
        
        // Way 2
        do {
            try Task.checkCancellation()
        } catch {
            print(error)
        }
    }
    
    @IBAction func fetchProfileInfo() {
        profileImageView.reset()
        profileFetchTask = Task {
            loadingIndicator.startAnimating()
            do {
                let user = try await HTTPClient.shared.delayUserFetchAPI()
                updateUI(user: user!)
                let profilePic = try await HTTPClient.shared.fetchImage(endPoint: user?.avatar ?? "")
                profileImageView.image = profilePic
                loadingIndicator.stopAnimating()
                print("Profile Fetched!")
                return user
            } catch {
                print(error)
            }
            return nil
        }
    }
    
    func updateUI(user: User) {
        firstNameLabel.text = user.first_name
        lastNameLabel.text = user.last_name
        emailLabel.text = user.email
    }
}


enum ProfileFetchError: Error {
    
}
