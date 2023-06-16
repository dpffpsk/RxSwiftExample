//
//  LoginViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/08.
//

import UIKit
import SnapKit
import RxSwift

class LoginViewController: UIViewController {

    let loginView = LoginView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupConstraints()
        setupBinding()
    }
    
    func setupLayout() {
        view.addSubview(loginView)
    }
    
    func setupConstraints() {
        loginView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // orEmpty : 옵셔널 String 걸러줌
    // skip : 지정한 횟수 만큼 이벤트를 skip 해줌
    // distinctUntilChanged : 이전 값과 비교하여 값이 같으면 건너뜀
    func setupBinding() {
        loginView.idTextField.rx.text
            .orEmpty
            .map({ return $0.contains("@") && $0.contains(".") })
            .distinctUntilChanged()
            .subscribe(onNext: {
                if $0 {
                    self.loginView.colorBoxView1.backgroundColor = .systemBlue
                } else {
                    self.loginView.colorBoxView1.backgroundColor = .systemRed
                }
            })
            .disposed(by: disposeBag)
        
        loginView.passwordTextField.rx.text
            .orEmpty
            .map(checkPassword(_:))
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {
                if $0 {
                    self.loginView.colorBoxView2.backgroundColor = .systemBlue
                } else {
                    self.loginView.colorBoxView2.backgroundColor = .systemRed
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func checkPassword(_ str: String) -> Bool {
        if str.count > 12 { // 12개 초과하는 문자 삭제
            let index = str.index(str.startIndex, offsetBy: 12)
            self.loginView.passwordTextField.text = String(str[..<index])
            
            return false
        } else if str.count < 7 {
            return false
        }

        return true
    }
}




