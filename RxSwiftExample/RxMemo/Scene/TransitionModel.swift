//
//  TransitionModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/18.
//

import Foundation

// 화면 전환 방식
enum TransitionStyle {
    case root
    case push
    case modal
}

// 화면 전환에서 발생하는 에러 정의
enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
