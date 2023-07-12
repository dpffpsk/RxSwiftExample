//
//  UsedGoodsModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/12.
//

import Foundation

struct UsedGoodsModel {
    func setAlert(errorMessage: [String]) -> (title: String, message: String?) {
        let title = errorMessage.isEmpty ? "성공" : "실패"
        let message = errorMessage.isEmpty ? nil : errorMessage.joined(separator: "\n")
        
        return (title: title, message: message)
    }
}
