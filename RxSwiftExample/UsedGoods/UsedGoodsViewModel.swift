//
//  UsedGoodsViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/03.
//

import Foundation
import RxSwift
import RxCocoa

struct UsedGoodsViewModel {
    let titleTextFieldViewModel = TitleTextFieldViewModel()
    let priceTextFieldViewModel = PriceTextFieldCellViewModel()
    let detailWriteFormCellViewModel = DetailWriteFormCellViewModel()
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    let presentAlert: Signal<Alert>
    let push: Driver<CategoryViewModel>
    
    // View -> ViewModel
    let itemSelected = PublishRelay<Int>()
    let submitButtonTapped = PublishRelay<Void>()
    
    init(model: UsedGoodsModel = UsedGoodsModel()) {
        // 초기화면 구성
        /// 글 제목
        let title = Observable.just("글 제목")
        
        /// 카테고리
        let categoryViewModel = CategoryViewModel()
        let category = categoryViewModel
            .selectedCategory
            .map { $0.name }
            .startWith("카테고리 선택")
        
        /// 가격
        let price = Observable.just("₩ 가격 (선택사항)")
        
        /// 상세내용
        let detail = Observable.just("내용을 입력하세요")
        
        /// 4개를 array로 묶음
        self.cellData = Observable
            .combineLatest(title, category, price, detail) { [$0, $1, $2, $3] }
            .asDriver(onErrorDriveWith: .empty())
        
        // alert 메세지 설정
        let titleMessage = titleTextFieldViewModel
            .titleText
            .map { $0?.isEmpty ?? true }
            .startWith(true) // 처음엔 true로 전달
            .map { $0 ? ["글 제목을 입력해주세요."] : [] } // 입력된 내용이 있으면 알랏 메세지 빈 값 전달
        
        let categoryMessage = categoryViewModel
            .selectedCategory
            .map { _ in false }
            .startWith(true)
            .map { $0 ? ["카테고리를 선택해주세요."] : [] }
        
        let detailMessage = detailWriteFormCellViewModel
            .contentValue
            .map { $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["내용을 입력해주세요."] : [] }
        
        /// 3개를 묶어서
        let errorMessage = Observable
            .combineLatest(titleMessage,
                           categoryMessage,
                           detailMessage
            ) { $0 + $1 + $2 }
        
        // 제출버튼이 탭되었을 때, Alert 뜨게
//        self.presentAlert = submitButtonTapped
//            .withLatestFrom(errorMessage) { $1 }
//            .map { errorMessage -> (title: String, message: String?) in
//                let title = errorMessage.isEmpty ? "성공" : "실패"
//                let message = errorMessage.isEmpty ? nil : errorMessage.joined(separator: "\n")
//
//                return (title: title, message: message)
//            }
//            .asSignal(onErrorSignalWith: .empty())
        
        self.presentAlert = submitButtonTapped
            .withLatestFrom(errorMessage) { $1 }
            .map(model.setAlert)
            .asSignal(onErrorSignalWith: .empty())
        
        // 카테고리 선택을 눌렀을 때만 푸시가 되게끔
        self.push = itemSelected
            .compactMap { row -> CategoryViewModel? in // 여러가지 row가 선택될 때마다 전달 됨
                guard case 1 = row else { // row 1(카테고리 셀)이라면 받고 아니면 nil
                    return nil
                }
                return categoryViewModel
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
