//
//  MemoListViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/18.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MemoListViewController: UIViewController, ViewModelBindableType {

    let disposeBag = DisposeBag()
    var viewModel: MemoListViewModel!
    
    let tableView = UITableView()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }
    
    func bindViewModel() {
        // 뷰모델에 저장되어 있는 title을 navigationItem에 바인딩
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        // 메모 목록을 tableView 셀에 바인딩
        viewModel.memoList.bind(to: tableView.rx.items(cellIdentifier: "cell")) { row, memo, cell in
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = memo.content
        }.disposed(by: disposeBag)
    }
    
    func attribute() {
        title = "메모 목록"
        view.backgroundColor = .white
        
        // barButton
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    
        let addButton = UIBarButtonItem(customView: button)
        navigationItem.setRightBarButton(addButton, animated: true)
        
        // tableView
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
