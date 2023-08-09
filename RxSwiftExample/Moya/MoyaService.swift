//
//  MoyaService.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/08/09.
//

import Foundation
import Moya

enum MoyaService: TargetType {
    case getUser(userId: String)
    case getAllUser(page: String)
    
    // Server base URL 지정
    var baseURL: URL { return URL(string: "https://reqres.in")! }
    
    // API Path 지정
    var path: String {
        switch self {
        case .getUser(let id):
            return "/api/users/\(id)"
        case .getAllUser(_):
            return "/api/users"
        }
    }
    
    // HTTP Method 지정
    var method: Moya.Method {
        switch self {
        case .getUser, .getAllUser:
            return .get
        }
    }
    
    // Parameters for requestt 지정
    var task: Task {
        switch self {
        case .getUser:
            return .requestPlain
        case .getAllUser(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        }
    }
    
    // HTTP headers 적용
    var headers: [String : String]? {
        switch self {
        case .getUser, .getAllUser:
            return ["Accept" : "application/json",
                    "Content-type" : "application/json"]
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getUser:
            return "should be filled properly".utf8Encoded
        }
    }
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
