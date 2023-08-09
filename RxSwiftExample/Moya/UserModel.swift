//
//  UserModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/08/09.
//

import Foundation

// MARK: - User
struct UserResponse: Codable {
    let data: Users
}

// MARK: - User
struct Users: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
