//
//  DelayResponseModel.swift
//  POCDemo
//
//  Created by DNREDDi on 24/01/23.
//

import Foundation

import Foundation

// MARK: - DelayResponse
struct DelayResponse: Codable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - Support
struct Support: Codable {
    let url: String
    let text: String
}

// Models
struct UserResponse: Codable {
    let data: User
}

struct User: Codable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
}
