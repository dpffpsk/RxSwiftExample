//
//  MemoComposeViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/18.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class MemoComposeViewModel: CommonViewModel {
    let disposeBag = DisposeBag()
    private let content: String?
    
    var initialText: Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: nil)
    }
    
    let cancelButtonTapped = PublishRelay<Void>()
    let saveButtonTapped = PublishRelay<String>()
    
    // T는 UIViewController의 하위 클래스여야한다는 제약 설정
    init<T: UIViewController>(title: String, content: String? = nil, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType, viewController: T) {
        self.content = content
        
        // 취소 버튼
        self.cancelButtonTapped
            .subscribe(onNext: { _ in
                viewController.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        // 저장 버튼
        self.saveButtonTapped
            .subscribe(onNext: { text in
                print("==================save")
            }).disposed(by: disposeBag)
        
        super.init(title: title, sceneCoordinator: sceneCoordinator as! SceneCoordinator, storage: storage)
    }
    
    
//    let saveAction: Action<String, Void>
//    let cancelAction: CocoaAction
    
//    init(title: String, content: String? = nil, sceneCoordinator: SceneCoordinatorType storage: MemoStorageType, saveAction: Action<String, Void>? = nil, cancelAction: CocoaAction? = nil ) {
//        self.content = content
//
//        // 뷰모델에서 버튼 액션을 구현하면 처리 방식이 하나로 고정됨
//        // 뷰모델에서 파라미터로 버튼 액션을 받으면 이전화면에서 처리 방식을 동적으로 결정할 수 있음
//
//        // 버튼 저장 액션
//        // 버튼 액션이 전달되면 액션 실행 후 화면을 닫음
//        self.saveAction = Action<String, Void> { input in
//            if let action = saveAction {
//                action.execute(input)
//            }
//
//            return SceneCoordinator.close(animated: )
//        }
//
//        // 버튼 취소 액션
//        self.cancelAction = CocoaAction {
//            if let action = cancelAction {
//                action.execute()
//            }
//
//            return sceneCoordinator.close(animated: true).asObservable().map{ _ in }
//        }
//
//        super.init(title: title, storage: storage)
//    }
}
