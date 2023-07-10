//
//  PriceTextFieldCell.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/04.
//

import UIKit
import RxSwift
import SnapKit
import RxCocoa

class PriceTextFieldCell: UITableViewCell {
    let disposeBag = DisposeBag()
    let priceInputField = UITextField()
    let freeshareButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: PriceTextFieldCellViewModel) {
        // ViewModel -> View
        /// freeshareButton 버튼 보여줄지 말지 제어
        /// showFreeShareButton이 true면 isHidden이 false가 되게 묶어줌
        viewModel.showFreeShareButton
            .map { !$0 }
            .emit(to: freeshareButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        /// 제출 버튼 누르면 가격 필드 초기화
        viewModel.resetPrice
            .map { _ in "" }
            .emit(to: priceInputField.rx.text)
            .disposed(by: disposeBag)
        
        
        // View -> ViewModel
        /// priceInputField와 priceValue 묶어줌
        priceInputField.rx.text
            .bind(to: viewModel.priceValue)
            .disposed(by: disposeBag)
        
        /// freeshareButton과 freeShareButtonTapped 이벤트 묶어줌
        freeshareButton.rx.tap
            .bind(to: viewModel.freeShareButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        // 무료나눔 버튼
        freeshareButton.setTitle("FREE", for: .normal)
        freeshareButton.setTitleColor(.white, for: .normal)
        freeshareButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        freeshareButton.titleLabel?.font = .systemFont(ofSize: 18)
        freeshareButton.tintColor = .systemBlue
        freeshareButton.backgroundColor = .systemBlue
        freeshareButton.layer.cornerRadius = 10.0
        freeshareButton.clipsToBounds = true
        freeshareButton.isHidden = true
        freeshareButton.semanticContentAttribute = .forceRightToLeft
        
        // 가격 텍스트필드
        priceInputField.keyboardType = .numberPad
        priceInputField.font = .systemFont(ofSize: 17)
    }
    
    private func layout() {
        [freeshareButton, priceInputField].forEach {
            contentView.addSubview($0)
        }
        
        priceInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        freeshareButton.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(15)
            $0.width.equalTo(100)
        }
    }
}
