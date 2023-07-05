//
//  PriceTextFieldCell.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/04.
//

import UIKit
import RxSwift

class PriceTextFieldCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        
    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        
    }
}
