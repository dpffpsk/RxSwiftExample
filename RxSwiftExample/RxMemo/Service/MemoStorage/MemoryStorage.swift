//
//  MemoryStorage.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/17.
//

import Foundation
import RxSwift

// 메모 저장
class MemoryStorage: MemoStorageType {
    // 메모를 저장할 배열
    private var list = [
        Memo(content: "Hello, RxSwift", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Lorem Ipsum", insertDate: Date().addingTimeInterval(-20))
    ]
    
    // 배열은 Observable을 통해 외부에 공개가 되고, Observable은 배열의 상태가 업데이트되면 새로은 Next 이벤트를 방출해야함
    // 그냥 Observable 형식이면 불가능하기때문에, Subject 형태로 만든다
    // 그리고 처음에 더미데이터를 표시해야하기 때문에, BehaviorSubject 활용
    private lazy var store = BehaviorSubject<[Memo]>(value: list)
    
    @discardableResult
    func createMemo(content: String) -> RxSwift.Observable<Memo> {
        // 새로운 메모 생성 및 추가
        let memo = Memo(content: content)
        list.insert(memo, at: 0)
        
        store.onNext(list)
        return Observable.just(memo) // 새로운 메모 방출
    }
    
    @discardableResult
    func memoList() -> RxSwift.Observable<[Memo]> {
        // 메모 리스트 출력
        return store
    }
    
    @discardableResult
    func update(memo: Memo, content: String) -> RxSwift.Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(updated)
    }
    
    @discardableResult
    func delete(memo: Memo) -> RxSwift.Observable<Memo> {
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(memo)
    }
}
