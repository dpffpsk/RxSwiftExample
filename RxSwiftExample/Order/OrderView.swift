//
//  OrderView.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/20.
//

import Foundation
import SnapKit
import UIKit
import Then


class OrderView: UIView {
    
    lazy var titleLabel = UILabel().then {
        $0.text = "Let's Order"
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    lazy var menuTableView = UITableView(frame: .zero, style: .plain)
    
    lazy var totalLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 40)
        $0.backgroundColor = .systemGray
    }
    
    lazy var orderButton = UIButton().then {
        $0.setTitle("ORDER", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .black
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(menuTableView)
        menuTableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.identifier)
        addSubview(totalLabel)
        addSubview(orderButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(70)
        }
        
        menuTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        totalLabel.snp.makeConstraints {
            $0.top.equalTo(menuTableView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        orderButton.snp.makeConstraints {
            $0.top.equalTo(totalLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
}
