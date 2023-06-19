//
//  MyTable.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/19.
//

import Foundation
import RxDataSources

struct MyTable {
    var header: String
    var items: [Item]
}

extension MyTable: AnimatableSectionModelType {
    typealias Item = Int
    
    var identity: String {
        return header
    }
    
    init(original: MyTable, items: [Int]) {
        self = original
        self.items = items
    }
}
