//
//  IssueListViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/01.
//

import UIKit
import RxSwift
import SnapKit
import Moya

//===========================================================================
// 수정중
//===========================================================================
// Controller : 검색 바에서 데이터를 받고, 모델을 전달하고, 이슈를 받고, 테이블 뷰에 보내주는 역할
class IssueListViewController: UIViewController {

    let issueListView = IssueListView()
    let disposeBag = DisposeBag()
    var provider: MoyaProvider<GitHub>! // Provider
    var latestRepositoryName: Observable<String> {
        return issueListView.searchBar.rx.text
            .orEmpty
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
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
        // 첫번째, 프로바이더를 생성
        provider = MoyaProvider<GitHub>()
        
        // 셀을 클릭했을 때, 테이블 뷰에게 알려줌
        // 키보드가 있다면, 숨김
        issueListView.tableView.rx.itemSelected
            .subscribe { indexPath in
                if self.issueListView.searchBar.isFirstResponder == true {
                    self.issueListView.endEditing(true)
                }
            }
            .disposed(by: disposeBag)
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
