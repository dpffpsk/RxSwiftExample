//
//  MoyaViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/08/09.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import RxMoya

class MoyaViewModel {
    
    private let service: MoyaProvider<MoyaService>
    private var disposeBag = DisposeBag()
    var userResponse = PublishSubject<UserResponse>()
    
    init(service: MoyaProvider<MoyaService> = MoyaProvider<MoyaService>()) {
        self.service = service
    }
    
    func fetchUser(id: String) {
        service.rx.request(.getUser(userId: id)).subscribe { [weak self] event in
            switch event {
            case let .success(response):
                do {
                    print(response.request?.url)
                    let filterResponse = try response.filterSuccessfulStatusCodes()
                    let userResponse = try filterResponse.map(UserResponse.self, using: JSONDecoder())
                    self?.userResponse.onNext(userResponse)
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
    
    func fetchAllUser() {
        service.rx.request(.getAllUser(page: "2")).subscribe { [weak self] event in
            switch event {
            case let .success(response):
                do {
//                    print(response.request?.url)
//                    let filterResponse = try response.filterSuccessfulStatusCodes()
                    
                    print(try response.mapJSON())
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
    
    func loginUser() {
        service.rx.request(.login(email: "eve.holt@reqres.in", password: "cityslicka")).subscribe { [weak self] event in
            switch event {
            case let .success(response):
                do {
//                    print(response.request?.url)
//                    let filterResponse = try response.filterSuccessfulStatusCodes()
                
                    print(try response.mapJSON())
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
}
