//
//  UserTableViewCell.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/08/08.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: "UserTableViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
