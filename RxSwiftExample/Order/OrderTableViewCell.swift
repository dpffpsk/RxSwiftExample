//
//  OrderTableViewCell.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/20.
//

import UIKit
import SnapKit
import Then

class OrderTableViewCell: UITableViewCell {
    static let identifier = "OrderTableViewCell"
    
    lazy var plusButton = UIButton().then {
        $0.setImage(UIImage(named: "plus"), for: .normal)
    }
    
    lazy var minusButton = UIButton().then {
        $0.setImage(UIImage(named: "minus"), for: .normal)
    }
    
    lazy var menuNameLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.setContentHuggingPriority(.init(rawValue: 250), for: .horizontal)
    }
    
    lazy var priceLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.setContentCompressionResistancePriority(.init(rawValue: 749), for: .horizontal)
    }
    
    lazy var landscapeStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
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
    
    private func setupLayout() {
        contentView.addSubview(landscapeStackView)

        landscapeStackView.addArrangedSubview(plusButton)
        landscapeStackView.addArrangedSubview(minusButton)
        landscapeStackView.addArrangedSubview(menuNameLabel)
        landscapeStackView.addArrangedSubview(priceLabel)
    }
    
    private func setupConstraints() {
        landscapeStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(10)
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
        
        priceLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
    }
}
