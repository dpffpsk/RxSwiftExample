//
//  Repository.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/27.
//

import Foundation

// Codable : Encodable, Decodable이 합쳐진 것
// Encodable : data를 Encoder에서 변환해주려는 프로토콜로 바꿔주는 것
// Decodable : data를 원하는 모델로 Decode 해주는 것

struct GitRepository: Codable {
    let id: Int
    let name: String
    let description: String
    let stargazersCount: Int
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, language
        case stargazersCount = "stargazers_count"
    }
}
