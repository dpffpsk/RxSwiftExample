//
//  OrderTableViewCell.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/20.
//

import UIKit
import SnapKit
import Then
import RxSwift

class OrderTableViewCell: UITableViewCell {
    static let identifier = "OrderTableViewCell"
    
    var disposeBag = DisposeBag()
    
    lazy var plusButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    lazy var minusButton = UIButton().then {
        $0.setImage(UIImage(systemName: "minus"), for: .normal)
        $0.tintColor = .systemRed
    }
    
    lazy var menuNameLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 23)
        $0.setContentHuggingPriority(.init(rawValue: 250), for: .horizontal)
    }
    
    lazy var leftBracket = UILabel().then {
        $0.text = "수량("
        $0.textColor = .systemGray
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textAlignment = .right
    }
    
    lazy var amountLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = .systemGray
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textAlignment = .center
    }
    
    lazy var rightBracket = UILabel().then {
        $0.text = ")"
        $0.textColor = .systemGray
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textAlignment = .left
    }
    
    lazy var priceLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
//        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textAlignment = .right
    }
    
    lazy var bracketStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 0
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    lazy var landscapeStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 테이블 뷰에서 셀이 재사용되기 전에 불려서 준비시켜 줌
    // tableView(_:cellForRowAt:)에서 초기화하는 것과 다른 점은?
    // 위의 함수는 셀 contents와 관련없는 것(알파 값 등)까지 재사용하기 때문에
    // 모든 subscribe를 종료할 수 있도록 전역변수로 선언한 disposeBag을 재할당해줌
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    private func setupLayout() {
        contentView.addSubview(landscapeStackView)

        landscapeStackView.addArrangedSubview(plusButton)
        landscapeStackView.addArrangedSubview(minusButton)
        landscapeStackView.addArrangedSubview(menuNameLabel)
        
        landscapeStackView.addArrangedSubview(bracketStackView)
        bracketStackView.addArrangedSubview(leftBracket)
        bracketStackView.addArrangedSubview(amountLabel)
        bracketStackView.addArrangedSubview(rightBracket)
        
        landscapeStackView.addArrangedSubview(priceLabel)
    }
    
    private func setupConstraints() {
        landscapeStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        plusButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(30)
        }
        
        minusButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(30)
        }
        
        menuNameLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        bracketStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(50)
        }
        
        leftBracket.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(23)
        }
        
        amountLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        rightBracket.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(5)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(40)
        }
    }
}
