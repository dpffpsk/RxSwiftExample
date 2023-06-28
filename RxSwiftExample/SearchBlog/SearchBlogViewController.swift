//
//  SearchBlogViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/28.
//

import UIKit
import RxSwift
import RxCocoa

class SearchBlogViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    // init : 데이터 관련 초기화할 때
    // viewDidLoad : 뷰 관련 초기화할 때
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind()
        attribute()
        layout()
        // badget
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        
    }
    
    private func attribute() {
        title = "다음 블로그 검색"
        view.backgroundColor = .white
    }
    
    private func layout() {
        
    }
}
