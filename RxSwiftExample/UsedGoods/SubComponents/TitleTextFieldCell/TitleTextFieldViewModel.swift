//
//  TitleTextFieldViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/03.
//

import RxCocoa

// 글 제목 Cell
struct TitleTextFieldViewModel {
    // UI 이벤트 받는 변수
    let titleText = PublishRelay<String?>()
}
