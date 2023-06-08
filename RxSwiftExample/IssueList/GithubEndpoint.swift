//
//  GithubEndpoint.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/01.
//

import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

enum GitHub {
    case userProfile(username: String)
    case repos(username: String)
    case repo(fullName: String)
    case issues(repositoryFullName: String)
}

// TargetType : url, method, task(request/upload/download), parameter, parameter encoding을 가지고 있는 protocol
// parameters는 필요하지 않기 때문에 nil 반환, method는 항상 .get 반환, baseURL도 항상 같은 값 반환
// sampleData와 path만 case에 맞춰서 분기
extension GitHub: TargetType {
    // 서버의 Base URL
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    // API 주소(baseURL 뒤에 붙음)
    var path: String {
        switch self {
        case .userProfile(username: let name):
            return "/users/\(name.URLEscapedString)"
        case .repos(username: let name):
            return "/users/\(name.URLEscapedString)/repos"
        case .repo(fullName: let name):
            return "/repos/\(name)"
        case .issues(repositoryFullName: let repositoryName):
            return "/repos/\(repositoryName)/issues"
        }
    }

    // HTTP method
    var method: Moya.Method {
        return .get
    }

    // request에 사용되는 파라미터 설정
    var task: Moya.Task {
        return .requestPlain
    }

    // HTTP header
    var headers: [String : String]? {
        return nil
    }

    var parameters: [String: Any]? {
        return nil
    }

    // 테스트용 Mock이나 Stub
    var sampleData: Data {
        switch self {
        case .userProfile(username: let name):
            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: .utf8)!
        case .repos(username: _):
            return "}".data(using: .utf8)!
        case .repo(fullName: _):
            return "{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}".data(using: .utf8)!
        case .issues(repositoryFullName: _):
            return "{\"id\": 132942471, \"number\": 405, \"title\": \"Updates example with fix to String extension by changing to Optional\", \"body\": \"Fix it pls.\"}".data(using: .utf8)!
        }
    }

    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
