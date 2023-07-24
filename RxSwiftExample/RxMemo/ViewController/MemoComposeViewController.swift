//
//  MemoComposeViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/18.
//

import UIKit
import RxSwift
import SnapKit

class MemoComposeViewController: UIViewController, ViewModelBindableType {

    let disposeBag = DisposeBag()
    var viewModel: MemoComposeViewModel!
    
    let cancelButton = UIBarButtonItem()
    let saveButton = UIBarButtonItem()
    let contentTextView = UITextView()
    
    let test = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
        
        test.addTarget(self, action: #selector(<#T##@objc method#>), for: <#T##UIControl.Event#>)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if contentTextView.isFirstResponder {
            contentTextView.resignFirstResponder()
        }
    }

    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        // 쓰기모드에서는 빈 문자열, 편집모드에서는 편집할 문자열 표시
        viewModel.initialText
            .drive(contentTextView.rx.text)
            .disposed(by: disposeBag)
        
        // 취소액션 바인딩
        cancelButton.rx.action = viewModel.cancelAction
        // throttle : 더블탭방지
        // withLatestFrom 텍스트 뷰에 입력된 텍스트 방출
        saveButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(contentTextView.rx.text.orEmpty)
            .bind(to: viewModel.saveAction.inputs)
            .disposed(by: disposeBag)
    }
    
    func attribute() {
        title = "새 메모"
        view.backgroundColor = .white
        
        // barButton
        cancelButton.title = "Cancel"
        navigationItem.setLeftBarButton(cancelButton, animated: true)
        
        saveButton.title = "Save"
        navigationItem.setRightBarButton(saveButton, animated: true)

        
    }
    
    func layout() {
        view.addSubview(contentTextView)
        
        contentTextView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
