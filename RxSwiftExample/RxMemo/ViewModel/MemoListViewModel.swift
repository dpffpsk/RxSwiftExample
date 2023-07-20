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
    
}
