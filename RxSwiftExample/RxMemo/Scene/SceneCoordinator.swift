//
//  SceneCoordinator.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/18.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

// 화면 이동 및 삭제(사용하지X)
class SceneCoordinator: SceneCoordinatorType {
    private let bag = DisposeBag()
    
//    private var window: UIWindow
    private var currentVC: UIViewController
    
    init(viewController: UIViewController) {
//        self.window = window
        self.currentVC = viewController
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        // 전환 결과를 방출할 Subject
        let subject = PublishSubject<Void>()
        
        // UIViewController
        let target = scene.instantiate()
        
        switch style {
        case .root:
            currentVC = target
            subject.onCompleted()
        
        case .push:
            currentVC.navigationController?.pushViewController(target, animated: true)
            currentVC = target
            subject.onCompleted()
            
        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target
        }
        
        return subject.ignoreElements().asCompletable()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            
            // 뷰컨트롤러가 모달이라면 현재 scene dismiss
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC
                    completable(.completed)
                }
            // 뷰컨트롤러가 네비게이션 stack에 있으면 pop
            } else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            } else {
                completable(.error(TransitionError.unknown))
            }
            
            return Disposables.create()
        }
    }
}
