//
//  IssueListViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/01.
//

import UIKit
import RxSwift
import SnapKit

// Controller : 검색 바에서 데이터를 받고, 모델을 전달하고, 이슈를 받고, 테이블 뷰에 보내주는 역할
class IssueListViewController: UIViewController {

    let issueListView = IssueListView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        issueListView.tableView.dataSource = self
        
        setupLayout()
        setupConstraint()
        setupRx()
    }
    
    func setupLayout() {
        view.addSubview(issueListView)
    }
    
    func setupConstraint() {
        issueListView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupRx() {
        
    }
}

extension IssueListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
