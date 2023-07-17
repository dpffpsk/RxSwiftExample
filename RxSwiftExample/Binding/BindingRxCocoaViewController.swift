//
//  BindingRxCocoaViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/17.
//

import UIKit
import RxCocoa
import RxSwift

// Rx 사용한 경우
class BindingRxCocoaViewController: UIViewController {

    let disposeBag = DisposeBag()
    let valueLabel = UILabel()
    let valueField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()

        valueField.becomeFirstResponder()
        
        valueField.layer.borderWidth = 1
        valueField.layer.borderColor = UIColor.black.cgColor
        
        // TextField에 입력된 값이 업데이트 될 때마나 Next 이벤트 전달
//        valueField.rx.text
//            .observe(on: MainScheduler.instance)
//            .subscribe { [weak self] str in
//                self?.valueLabel.text = str
//            }
//            .disposed(by: disposeBag)
        
        // bind(to:) : Observable이 방출한 이벤트를 Observer에게 전달
        // binder가 binding을 Main Thread에서 실행해주기 때문에, Main Thread를 직접 지정할 필요 없음
        valueField.rx.text
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        valueField.resignFirstResponder()
    }
    
    private func layout() {
        view.backgroundColor = .white
        view.addSubview(valueLabel)
        view.addSubview(valueField)
        
        valueLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
        
        valueField.snp.makeConstraints {
            $0.top.equalTo(valueLabel.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
    }
}
