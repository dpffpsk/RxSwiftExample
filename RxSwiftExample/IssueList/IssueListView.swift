//
//  IssueListView.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/01.
//

import Foundation
import UIKit
import SnapKit

class IssueListView: UIView {
    
    lazy var searchBar = UISearchBar()
    lazy var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        searchBar.placeholder = "미완성 기능"
        addSubview(searchBar)
        addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "IssueListCell")
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
