//
//  MemoListViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/18.
//

import Foundation
import RxSwift
import RxCocoa

class MemoListViewModel: CommonViewModel {
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
    
    let buttonTapped = PublishRelay<Void>()
    

    func performUpdate(memo: Memo, content: String) {
        self.storage.update(memo: memo, content: content)
    } 
    
    func makeCreateAction() {
        self.storage.createMemo(content: "")
            .flatMap { memo -> Observable<Void> in
                let composeViewModel = MemoComposeViewModel(title: "새 메모", sceneCoordinator: self.sceneCoordinator, storage: self.storage, viewController: MemoListViewController())
                let composeScene = Scene.compose(composeViewModel)
                
                
                return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map{ _ in }
            }
    }
}
