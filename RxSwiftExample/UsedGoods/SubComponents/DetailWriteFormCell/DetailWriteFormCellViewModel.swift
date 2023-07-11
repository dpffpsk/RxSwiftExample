//
//  DetailWriteFormCellViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/10.
//

import Foundation
import RxCocoa

struct DetailWriteFormCellViewModel {
    let contentValue = PublishRelay<String?>()
}
