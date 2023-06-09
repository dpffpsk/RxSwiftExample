//
//  IssueTrackerModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/08.
//

import Foundation
import Moya
import RxSwift
import RxOptional

struct IssueTrackerModel {
    let provider: MoyaProvider<GitHub>
    let repositoryName: Observable<String>
    
//    func trackIssues() -> Observable<[Issue]> {
//        return repositoryName
//            .observe(on: MainScheduler.instance)
//    }

    // Github.issues 에 요청 보냄
//    internal func findIssues(repository: Repository) -> Observable<[Issue]?> {
//    }
    
    // Github.repo 에 요청 보냄
//    internal func findRepository(name: String) -> Observable<Repository?> {
//    }
}
