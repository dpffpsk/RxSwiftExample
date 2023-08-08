//
//  CommonViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/18.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel: NSObject {
    let title: Driver<String>
    let sceneCoordinator: SceneCoordinatorType
    let storage: MemoStorageType
    
//    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
    init(title: String, sceneCoordinator: SceneCoordinator, storage: MemoStorageType) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
}
