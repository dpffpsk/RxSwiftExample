//
//  Memo.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/17.
//

import Foundation

// Equatable : 타입끼리 비교연산을 하기 위해선 필수적으로 구현해야 하는 프로토콜
struct Memo: Equatable {
    var content: String
    var insertDate: Date
    var identity: String
    
    init(content: String, insertDate: Date = Date()) {
        self.content = content
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }
    
    init(original: Memo, updatedContent: String) {
        self = original
        self.content = updatedContent
    }
}
