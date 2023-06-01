//
//  CircleViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/05/31.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class CircleViewModel {
    
    var centerObservable: BehaviorSubject<CGPoint> = BehaviorSubject(value: CGPoint(x: 0.0, y: 0.0)) // subscribe한 원의 가장 최근 중앙 지점만 가져옴
    var backgroundColorObservable: BehaviorSubject<UIColor> = BehaviorSubject(value: UIColor.black)
//    var backgroundColorObservable: Observable<UIColor>!
    var disposeBag = DisposeBag()
    
    init() {
        setup()
    }
    
    func setup() {
        // Observable(수신)
        // 새로운 중앙 값을 받으면, 새로운 UIColor를 반환
        // bind : 값을 넘겨줄 때 사용
        centerObservable.map { center in
            var r: CGFloat = ((center.x + center.y).truncatingRemainder(dividingBy: 255) / 255.0)
            let g: CGFloat = 0.1
            let b: CGFloat = 0.1
            
            let rs = String(format: "%.1f", r) // 소수점 아래 1자리까지
            r = self.stringToCgFloat(rs)
            
            return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
        }
        .bind(to: backgroundColorObservable)
        .disposed(by: disposeBag)
        
        // Subject.asObservable() : Subject는 Observer와 Observable 역할을 다 하는데, 외부에서 Observer에 접근하지 못하도록 설정하며 Observable에만 접근할 수 있도록 나눠서 접근 가능하도록 하기위함
//        backgroundColorObservable = centerObservable.asObservable().map({ center in
//
//            // 새로운 CGPoint 값을 UIColor로 연결
//            var r: CGFloat = ((center.x + center.y).truncatingRemainder(dividingBy: 255) / 255.0)
//            let g: CGFloat = 0.0
//            let b: CGFloat = 0.0
//
//            let rs = String(format: "%.1f", r) // 소수점 아래 1자리까지
//            r = self.stringToCgFloat(rs)
//
//            return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
//        })
    }
    
    func stringToCgFloat(_ s: String) -> CGFloat {
        let float = Float(s)!
        return CGFloat(float)
    }
}

