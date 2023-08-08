//
//  User.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/08/08.
//

import Foundation

struct User: Codable {
    let userID, id: Int
    let title, body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body  
    }
}
