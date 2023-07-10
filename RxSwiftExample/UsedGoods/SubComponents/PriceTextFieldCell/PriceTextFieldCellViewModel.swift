//
//  PriceTextFieldCellViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/04.
//

import Foundation
import RxSwift
import RxCocoa

struct PriceTextFieldCellViewModel {
    
    // ViewModel -> View 이벤트 전달
    let showFreeShareButton: Signal<Bool> // 무료나눔 버튼
    let resetPrice: Signal<Void>
    
    // View -> ViewModel 이벤트 전달
    let priceValue = PublishRelay<String?>()
    let freeShareButtonTapped = PublishRelay<Void>()
    
    init() {
        // 무료나눔 버튼이 언제 보여질지
        self.showFreeShareButton = Observable
            .merge(
                // priceValue를 확인했을 때, 빈 값이거나 0을 입력했을 경우
                priceValue.map { $0 ?? "" == "0" },
                // 무료나눔 버튼이 눌렸을 경우, 버튼을 숨겨라
                freeShareButtonTapped.map { _ in false }
            )
            .asSignal(onErrorJustReturn: false) // 에러가 나면 버튼 숨김
        
        self.resetPrice = freeShareButtonTapped
            .asSignal(onErrorSignalWith: .empty())
    }
}
