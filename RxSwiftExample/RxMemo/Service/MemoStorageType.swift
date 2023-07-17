//
//  MemoStorageType.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/17.
//

import Foundation
import RxSwift

// 이 프로토콜을 구현한 스토리지
protocol MemoStorageType {
    // CRUD
    // @discardableResult :return 값을 사용하지 않아도 warning 메세지 나오지 않도록 설정
    @discardableResult
    func createMemo(content: String) -> Observable<Memo>
    
    @discardableResult
    func memoList() -> Observable<[Memo]>
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo>
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo>
}
