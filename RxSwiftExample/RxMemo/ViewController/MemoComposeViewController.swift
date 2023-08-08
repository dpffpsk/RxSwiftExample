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
        
        // 취소버튼 이벤트 바인딩
        cancelButton.rx.tap
            .bind(to: viewModel.cancelButtonTapped)
            .disposed(by: disposeBag)
//        cancelButton.rx.tap
//            .subscribe(onNext: { event in
//                self.dismiss(animated: true)
//            }).disposed(by: disposeBag)
        
        // 저장버튼 이벤트 바인딩
        // 텍스트 뷰에 입력된 문자를 저장해야함
        // throttle : 더블탭방지
        // withLatestFrom : 가장 최신의 이벤트만 방출(텍스트 뷰에 입력된 텍스트 방출)
        // orEmpty : 옵셔널 string 걸러줌
        saveButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(contentTextView.rx.text.orEmpty)
            .bind(to: viewModel.saveButtonTapped)
            .disposed(by: disposeBag)
//        saveButton.rx.tap
//            .throttle(.microseconds(500), scheduler: MainScheduler.instance)
//            .withLatestFrom(contentTextView.rx.text.orEmpty)
//            .subscribe(onNext: { event in
//                self.dismiss(animated: true)
//            }).disposed(by: disposeBag)
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
