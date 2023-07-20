//
//  MemoListViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/18.
//

import UIKit

class MemoListViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoListViewModel!
    
    let tableview = UITableView()
    let addButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func bindViewModel() {
        
    }
    
    func attribute() {
        title = "메모 목록"
        view.backgroundColor = .white
        
        addButton.style = .plain
        addButton.title = "ADD"
        
        ad
    }
    
    func layout() {
        
    }
}
