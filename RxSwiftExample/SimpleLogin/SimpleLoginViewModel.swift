//
//  SimpleLoginViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/20.
//

import Foundation
import RxCocoa
import RxSwift

class SimpleLoginViewModel {
    
    let emailObserver = BehaviorRelay<String>(value: "")
    let passwordObserver = BehaviorRelay<String>(value: "")
    
    // 유효성 검사
    var isValid: Observable<Bool> {
        return Observable.combineLatest(emailObserver, passwordObserver)
            .map { email, password in
                print("Email : \(email), Password: \(password)")
                return !email.isEmpty && email.contains("@") && email.contains(".") && password.count > 0
            }
    }
}
