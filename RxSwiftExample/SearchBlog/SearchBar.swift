//
//  SearchBar.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/28.
//

import UIKit
import RxSwift
import RxCocoa

class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    
    // 검색 버튼
    let searchButton = UIButton()
    
    // SearchBar 버튼 탭 이벤트
    // Relay : error를 뱉지않고, UI변경에 특화 됨
    // Void : 값을 전달하지 않고, 탭 이벤트만 전달
    let searchButtonTapped = PublishRelay<Void>()
    
    // SearchBar 외부로 내보낼 이벤트
    var shouldLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        // 서치바의 서치 버튼(돋보기) 탭 되었을 때
        // 검색 버튼이 탭 되었을 때
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(),
                searchButton.rx.tap.asObservable()
            )
            .bind(to: searchButtonTapped)
            .disposed(by: disposeBag)
        
        searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
        
        // searchButtonTapped 이벤트가 발생했을 때, 가장 최신의 텍스트 가져옴, 텍스트가 없다면 빈 값으
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(self.rx.text) { $1 ?? "" }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }
    
    private func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    private func layout() {
        addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}

// 키보드 내리는 동작 Custom
extension Reactive where Base: SearchBar {
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
