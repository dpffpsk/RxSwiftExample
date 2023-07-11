//
//  UsedGoodsViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/03.
//

import UIKit
import RxSwift
import SnapKit

/*
 UIViewController Lifecycle
 init > loadView > viewDidLoad > viewWillAppear > viewDidAppear > viewWillDisappear > viewDidDisappear > viewDidUnload
 */
class UsedGoodsViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    let submitButton = UIBarButtonItem()
    
    // UIViewController 지정 이니셜라이저이다.
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func attribute() {
        title = "중고거래 글쓰기"
        view.backgroundColor = .white
        
        submitButton.title = "제출"
        submitButton.style = .done
        
        navigationItem.setRightBarButton(submitButton, animated: true)
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: "TitleTextFieldCell")   // index row 0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryListCell")        // index row 1
        tableView.register(PriceTextFieldCell.self, forCellReuseIdentifier: "PriceTextFieldCell")   // index row 2
        tableView.register(DetailWriteFormCell.self, forCellReuseIdentifier: "DetailWriteFormCell") // index row 3
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bind(_ viewModel: UsedGoodsViewModel) {
        
    }
}

// Alert 커스텀
typealias Alert = (title: String, message: String?)
extension Reactive where Base: UsedGoodsViewController {
    var setAlert: Binder<Alert> {
        return Binder(base) { base, data in
            let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertController.addAction(action)
            base.present(alertController, animated: true, completion: nil)
        }
    }
}
