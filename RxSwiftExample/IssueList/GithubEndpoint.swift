//
//  GithubEndpoint.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/01.
//

import Foundation
import Moya

enum GitHub {
    case userProfile(username: String)
    case repos(username: String)
    case repo(fullName: String)
    case issues(repositoryFullName: String)
}

// TargetType : url, method, task(request/upload/download), parameter, parameter encoding을 가지고 있는 protocol
extension GitHub: TargetType {


//    var method: Moya.Method {
//        return .get
//    }
//    var parameters: [String: Any]? {
//        return nil
//    }
//    var sampleData: Data {
//        switch self {
//        case .repos(_):
//            return "}".data(using: .utf8)!
//        case .userProfile(let name):
//            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: .utf8)!
//        case .repo(_):
//            return "{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}".data(using: .utf8)!
//        case .issues(_):
//            return "{\"id\": 132942471, \"number\": 405, \"title\": \"Updates example with fix to String extension by changing to Optional\", \"body\": \"Fix it pls.\"}".data(using: .utf8)!
//        }
//    }
//    var task: Task {
//        return .request
//    }
//    var parameterEncoding: ParameterEncoding {
//        return JSONEncoding.default
//    }
}
