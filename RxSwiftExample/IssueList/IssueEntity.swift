//
//  IssueEntity.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/08.
//

import Foundation
import Mapper

struct Issue: Mappable {
    let identifier: Int
    let number: Int
    let title: String
    let body: String
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try number = map.from("number")
        try title = map.from("title")
        try body = map.from("body")
    }
}
