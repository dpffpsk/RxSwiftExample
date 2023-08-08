//
//  MVVMTestViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/08/08.
//

import UIKit
import RxSwift
import RxCocoa

class MVVMTestViewController: UIViewController {

    private var viewModel = MVVMTestViewModel()
    private var disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        viewModel.fetchUsers()
        bindTableView()
    }
    
    func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.users.bind(to: tableView.rx.items(cellIdentifier: "UserTableViewCell", cellType: UserTableViewCell.self)) {
            row, item, cell in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            content.secondaryText = "\(item.id)"
            cell.contentConfiguration = content
            
        }.disposed(by: disposeBag)
        
//        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
//            print(indexPath.row)
//        }).disposed(by: disposeBag)
//        
//        tableView.rx.itemDeleted.subscribe(onNext: { [weak self] indexPath in
//            guard let self = self else { return }
//            self.viewModel.deleteUser(index: indexPath.row)
//        }).disposed(by: disposeBag)
    }

}

extension MVVMTestViewController: UITableViewDelegate {
    
}
