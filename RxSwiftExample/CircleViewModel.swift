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
    var backgroundColorObservable: Observable<UIColor>!
    var disposeBag = DisposeBag()
    
    init() {
        setup()
    }
    
    func setup() {
        // 새로운 중앙 값을 받으면, 새로운 UIColor를 반환
        backgroundColorObservable = centerObservable.asObservable().map({ center in
            
//            guard let center = center else { return UIColor.black } // Optional이기 때문에 디폴트 색상을 black으로 지정
            
            // 새로운 CGPoint 값을 UIColor로 연결
            var r: CGFloat = ((center.x + center.y).truncatingRemainder(dividingBy: 255) / 255.0)
            let g: CGFloat = 0.0
            let b: CGFloat = 0.0
            
//            let rs = String(format: "%.1f", r)
//            r = self.stringToCgFloat(rs)
            
            return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
            
        })
    }
    
    func stringToCgFloat(_ s: String) -> CGFloat {
        let float = Float(s)!
        return CGFloat(float)
    }
}

