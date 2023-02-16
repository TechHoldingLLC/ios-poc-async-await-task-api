//
//  ViewController.swift
//  POCDemo
//
//  Created by DNREDDi on 22/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    
    let httpClient = HTTPClient.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            let user = try await HTTPClient.shared.delayUserFetchAPI()
            print(user)
        }
        
        Task {
            let user = try await HTTPClient.shared.fetchUser()
            print("Single User: \(user)")
        }
    }
    
    @IBAction func fetchImage() {
        Task {
            let image = try? await HTTPClient.shared.loadImage(number: 1)
            imageView.image = image
        }
    }
    
    @IBAction func fetch2Images() {
        imageView2.image = UIImage(named: "")
        imageView3.image = UIImage(named: "")
        imageView4.image = UIImage(named: "")
        imageView5.image = UIImage(named: "")
        
        Task {
            print("\(Task.currentPriority)")
            let image = try? await HTTPClient.shared.loadImage(number: 2)
            imageView2.image = image
        }
        
        Task {
            print("\(Task.currentPriority)")
            let image = try? await HTTPClient.shared.loadImage(number: 3)
            imageView3.image = image
        }
        
        Task {
            print("\(Task.currentPriority)")
            let image = try? await HTTPClient.shared.loadImage(number: 4)
            imageView4.image = image
        }
        
        Task {
            print("\(Task.currentPriority)")
            let image = try? await HTTPClient.shared.loadImage(number: 5)
            imageView5.image = image
        }
    }
    
    @IBAction func fetchSequencially() { // Wrap dependent tasks
        
        imageView2.image = UIImage(named: "")
        imageView3.image = UIImage(named: "")
        imageView4.image = UIImage(named: "")
        imageView5.image = UIImage(named: "")
        
        Task {
            print("\(Task.currentPriority)")
            var image = try? await HTTPClient.shared.loadImage(number: 2)
            imageView2.image = image
        
            print("\(Task.currentPriority)")
            image = try? await HTTPClient.shared.loadImage(number: 3)
            imageView3.image = image
        
            image = try? await HTTPClient.shared.loadImage(number: 4)
            imageView4.image = image
        
            image = try? await HTTPClient.shared.loadImage(number: 5)
            imageView5.image = image
        }
    }
    
    @IBAction func fetchAllAtOnce() {
        imageView6.image = UIImage(named: "")
        imageView7.image = UIImage(named: "")
        imageView8.image = UIImage(named: "")
        imageView9.image = UIImage(named: "")
        
        Task {
            async let image6 = HTTPClient.shared.loadImage(number: 6)
            async let image7 = HTTPClient.shared.loadImage(number: 7)
            async let image8 = HTTPClient.shared.loadImage(number: 8)
            async let image9 = HTTPClient.shared.loadImage(number: 9)
            
            let images = await [try image6, try image7, try image8, try image9]
            
            print("All images fetched!")
            imageView6.image = images[0]
            imageView7.image = images[1]
            imageView8.image = images[2]
            imageView9.image = images[3]
        }
    }
    
    
//    @IBAction func buttonPressed() { //One After Another
//        print("Starting")
//        Task {
//            print("T1 - Start")
//            let user = try? await self.viewModel.httpClient.fetchUser()
//            print("User - 1: \(user)")
//            print("T1 - End")
//        }
//
//        Task {
//            print("T2 - Start")
//            let user = try? await self.viewModel.httpClient.fetchUser()
//            print("User - 2: \(user)")
//            print("T2 - End")
//        }
//        print("Ending")
//    }
}



// A method which is having asynchronous code must be marked as async
// Async method calling must be preceed with await or Wrapped inside a task
// Use Task in ViewController
// Methods which are wrapped inside task executes sequencially


class TestTwo {
    
//    func add(completion: @escaping (User) ->(Void)) {
//        HTTPClient.shared.fetchUser { result in
//            switch result {
//            case .success(let user):
//                print(user)
//                completion(user)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    func add1() async -> User? {
        do {
            let user = try await HTTPClient.shared.fetchUser()
            print(user)
            return user
        } catch let error {
            print(error)
            return nil
        }
    }
    
    //-------------
    
    @available(*, renamed: "add2()")
    func add2(completion: @escaping (User) ->(Void)) {
        Task {
            let result = await add2()
            completion(result!)
        }
    }
    
    
    func add2() async -> User? {
        do {
            let user = try await HTTPClient.shared.fetchUser()
            print(user)
            return user
        } catch let error {
            print(error)
            return nil
        }
    }
    
    //-------------
    
    @available(*, renamed: "add3()")
    func add3(completion: @escaping (User) ->(Void)) {
        HTTPClient.shared.fetchUser { result in
            switch result {
            case .success(let user):
                print(user)
                completion(user)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func add3() async -> User {
        return await withCheckedContinuation { continuation in
            add3() { result in
                continuation.resume(returning: result)
            }
        }
    }
    
}

