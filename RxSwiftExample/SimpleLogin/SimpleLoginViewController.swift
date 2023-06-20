//
//  SimpleLoginViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/20.
//

import UIKit
import SnapKit
import Then
import RxSwift

class SimpleLoginViewController: UIViewController {
    let disposeBag = DisposeBag()
    let loginView = SimpleLoginView()
    var loginViewModel = SimpleLoginViewModel()
    
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
    
    func setupBinding() {
        loginView.emailTextField.rx.text
            .orEmpty
            .bind(to: loginViewModel.emailObserver)
            .disposed(by: disposeBag)
        
        loginView.passwordTextField.rx.text
            .orEmpty
            .bind(to: loginViewModel.passwordObserver)
            .disposed(by: disposeBag)
        
        loginViewModel.isValid.bind(to: loginView.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginViewModel.isValid
            .map { $0 ? 1 : 0.3 }
            .bind(to: loginView.loginButton.rx.alpha)
            .disposed(by: disposeBag)
        
        loginView.loginButton.rx.tap.subscribe(
            onNext: { [weak self] _ in
                let alert = UIAlertController(title: "LOGIN YEH~🙌", message: "환영합니다", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                alert.addAction(ok)
                self?.present(alert, animated: true, completion: nil)
            }
        ).disposed(by: disposeBag)
    }
}
