//
//  CategoryViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/04.
//

import RxSwift
import RxCocoa

// 카테고리 선택 셀
struct CategoryViewModel {
    let disposeBag = DisposeBag()

    // ViewModel -> View
    /// 카테고리 데이터
    let cellData: Driver<[Category]>
    /// pop 이벤트
    let pop: Signal<Void>
    
    // View -> ViewModel
    /// 선택된 카테고리가 무엇인지 row값 가져오기
    let itemSelected = PublishRelay<Int>()
    
    // ViewModel -> ParentsViewModel
    /// 메인뷰에 전달할 카테고리
    let selectedCategory = PublishSubject<Category>()
    
    init() {
        let categories = [
            Category(id: 1, name: "디지털/가전"),
            Category(id: 2, name: "게임"),
            Category(id: 3, name: "스포츠/레저"),
            Category(id: 4, name: "유아/아동용품"),
            Category(id: 5, name: "여성패션/잡화"),
            Category(id: 6, name: "뷰티/미용"),
            Category(id: 7, name: "남성패션/잡화"),
            Category(id: 8, name: "생활/식품"),
            Category(id: 9, name: "가구"),
            Category(id: 10, name: "도서/티켓/취미"),
            Category(id: 11, name: "기타")
        ]
        
        // driver로 전달
        self.cellData = Driver.just(categories)
        
        // itemSelected와 selectedCategory를 묶어서 선택된 카테고리가 itemSelected 통해 selectedCategory로 전달되게 함
        // 외부에서는 selectedCategory만 확인하면 선택된 카테고리를 알 수 있게끔 함
        self.itemSelected
            .map { categories[$0] }
            .bind(to: selectedCategory)
            .disposed(by: disposeBag)
        
        self.pop = itemSelected.map{ _ in Void() }.asSignal(onErrorSignalWith: .empty())
    }
}
