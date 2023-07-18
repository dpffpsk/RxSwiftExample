//
//  ViewModelBindableType.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/18.
//

import Foundation
import UIKit

protocol ViewModelBindableType {
    // 제네릭 프로토콜로 선언(뷰모델의 타입은 뷰컨트롤러마다 달라지기 때문에)
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

// 프로토콜 extension
extension ViewModelBindableType where Self: UIViewController {
    // 뷰컨트롤러에 추가된 뷰 모델을 저장하고, bindViewModel 메서드를 자동으로 호출하는 메서드
    // 개별 뷰컨트롤러에서 bind 메서드를 직접 호출할 필요가 없게 됨
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
