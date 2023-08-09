//
//  MoyaViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/08/09.
//

import UIKit
import RxSwift

class MoyaViewController: UIViewController {

    private var viewModel = MoyaViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchUser(id: "2")
        
        viewModel.userResponse.subscribe { userResponse in
            print(userResponse.element)
        }.disposed(by: disposeBag)
        
        viewModel.fetchAllUser()
        
    }

}
