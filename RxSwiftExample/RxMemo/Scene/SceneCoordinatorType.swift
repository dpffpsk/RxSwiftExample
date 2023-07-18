//
//  SceneCoordinatorType.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/18.
//

import Foundation
import RxSwift

// SceneCoordinator가 공통적으로 구현해야하는 멤버 선언
protocol SceneCoordinatorType {
    // 새로운 scene 표시
    // Completable : Observable 이고, .completed, .error 두 가지만 존재하고, 따로 값을 방출 x, 특정 처리가 제대로 완료되었는지만 확인하고 싶을 때 많이 사용
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    
    // 현재 scene 닫고, 이전 scene로 돌아감
    @discardableResult
    func close(animated: Bool) -> Completable
}
