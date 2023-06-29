//
//  FilterView.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/28.
//

import RxCocoa
import RxSwift
import UIKit
import SnapKit

class FilterView: UITableViewHeaderFooterView {
    let disposeBag = DisposeBag()
    
    // 필터 버튼
    let sortButton = UIButton()
    let bottomBorder = UIView()
    
    // 필터뷰 버튼의 이벤트를 바깥으로 전달해줘서 메인 뷰 위에서 알랏이 떠야함
    let sortButtonTapped = PublishRelay<Void>()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        sortButton.rx.tap
            .bind(to: sortButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        sortButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        bottomBorder.backgroundColor = .lightGray
    }
    
    private func layout() {
        [sortButton, bottomBorder]
            .forEach { addSubview($0) }
        
        sortButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(28)
        }
        
        bottomBorder.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
