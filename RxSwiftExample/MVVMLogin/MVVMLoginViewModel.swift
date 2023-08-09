//
//  MVVMLoginViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/08/09.
//

import Foundation
import RxCocoa
import RxSwift

class MVVMLoginViewModel {
    
    var email: BehaviorSubject<String> = BehaviorSubject(value: "")
    var password: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    var isValidEmail: Observable<Bool> {
        email.map {
            $0.isValidEmail()
        }
    }
    
    var isValidPassword: Observable<Bool> {
        password.map {
            return $0.count < 6 ? false : true
        }
    }
    
    var isValidInput: Observable<Bool> {
        return Observable.combineLatest(isValidEmail, isValidPassword).map({ $0 && $1 })
    }
}

// 정규식
/// [A-Z0-9a-z._%+-] : 대소문자, 숫자, 특수문자 사용 가능
/// +@ : 사이에 @ 무조건 필수
/// [A-Za-z0-9.-] : 대소문자, 숫자 사용 가능
/// +\\. : 사이에 . 무조건 필수
/// [A-Za-z] : 대소문자 사용 가능
/// {2,6} : 앞의 [A-Za-z]를 2~6 자리로 제한
extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}")
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
