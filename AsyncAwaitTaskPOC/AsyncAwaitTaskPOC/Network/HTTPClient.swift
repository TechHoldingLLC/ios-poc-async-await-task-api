//
//  HTTPClient.swift
//  POCDemo
//
//  Created by DNREDDi on 24/01/23.
//

import Foundation
import UIKit

class HTTPClient {
    static let shared = HTTPClient()
    private init() { }
    
    // Existing way of asynchronous API Calling
    func fetchUser(completionHandler: @escaping ((Result<User, Error>) -> Void)) {
        let url = URL(string: "https://reqres.in/api/users/2")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let user = try JSONDecoder().decode(User.self, from: data!)
                completionHandler(.success(user))
            } catch {
                completionHandler(.failure(error))
            }
        } .resume()
    }

    // Asyncnronous API call with Async in a structured way
    func fetchUser() async throws -> User {
        do {
            let url = URL(string: "https://reqres.in/api/users/2")
            let (data, _) = try await URLSession.shared.data(from: url!)
            let user = try JSONDecoder().decode(UserResponse.self, from: data)
            return user.data
        } catch {
            print(error)
            throw error
        }
    }

    func loadImage(number: Int, delayFetch: Int = 0) async throws -> UIImage {
        print("Downlaod Image: \(number)")
        let urlString = "https://picsum.photos/200"
        let url = URL(string: urlString)
        try? await Task.sleep(nanoseconds: UInt64(delayFetch * 1_000_000_000))
        do {
            let (data, _) = try await URLSession.shared.data(from: url!)
            if let image = UIImage(data: data) {
                return image
            }
            return UIImage()
        } catch {
            throw error
        }
    }
    
    func fetchImage(endPoint: String) async throws -> UIImage {
        let urlString = endPoint
        let url = URL(string: urlString)
        do {
            let (data, _) = try await URLSession.shared.data(from: url!)
            if let image = UIImage(data: data) {
                return image
            }
            return UIImage()
        } catch {
            throw error
        }
    }
    
    func delayUserFetchAPI(delay: Int = 5) async throws -> User? {
        let urlString = "https://reqres.in/api/users?delay=\(delay)"
        let url = URL(string: urlString)
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url!)
            let res = try? JSONDecoder().decode(DelayResponse.self, from: data)
            let index = Int.random(in: 1...res!.data.count - 1)
            return res?.data[index]
        } catch {
            throw error
        }
    }
}
