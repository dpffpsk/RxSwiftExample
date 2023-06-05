//
//  CitySearcherView.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/05/31.
//

import UIKit
import SnapKit
import Then

class CitySearcherView: UIView {

    lazy var searchBar = UISearchBar(frame: .zero)
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        backgroundColor = .white
        addSubview(searchBar)
        addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CitySearcherCell")
    }
    
    func setupConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
