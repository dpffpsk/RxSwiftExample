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
    }
    
    lazy var priceLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
    }
    
    private func setupConstraints() {
        
    }
    
}
