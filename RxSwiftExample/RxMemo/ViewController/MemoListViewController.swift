//
//  MemoListViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/18.
//

import UIKit

class MemoListViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "메모 목록"
    }
    
    func bindViewModel() {
        
    }
}
