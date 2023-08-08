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
        self.title = "Users"
        let add = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(onTapAdd))
        self.navigationItem.rightBarButtonItem = add
        self.view.addSubview(tableView)
        viewModel.fetchUsers()
        bindTableView()
    }
    
    @objc func onTapAdd() {
        let user = User(userID: 50001, id: 42343, title: "wony", body: "Look at this!!!!!!!!!")
        self.viewModel.addUser(user: user)
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
        
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            let alert = UIAlertController(title: "Alert", message: "Edit Note", preferredStyle: .alert)
            alert.addTextField { textfield in
                
            }
            
            alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { action in
                let textField = alert.textFields![0] as UITextField
                self.viewModel.editUser(title: textField.text ?? "", index: indexPath.row)
            }))
            
            DispatchQueue.main.async {
                print("alert")
                self.present(alert, animated: true)
            }
        }).disposed(by: disposeBag)
        
        tableView.rx.itemDeleted.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            self.viewModel.deleteUser(index: indexPath.row)
        }).disposed(by: disposeBag)
    }

}

extension MVVMTestViewController: UITableViewDelegate {
    
}
