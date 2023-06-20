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
    
    // BehaviorSubject : Subject로 전달되는 새로운 이벤트를 구독자로 전달한다. 다른 Subject와 다른 점은 생성시점에 초기값을 구현하고 구독시 최신 이벤트를 저장해두었다가 전달하는 것이다. 구독자에게 completed가 전달되고 더 이상 추가적인 이벤트를 전달하지 않는다.
    let idText: BehaviorSubject<String> = BehaviorSubject(value: "")
    let passwordText: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    let idValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let passwordValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
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
    func setupBinding() {
        // input
        loginView.idTextField.rx.text.orEmpty
            .bind(to: idText)
            .disposed(by: disposeBag)
        
        idText.map(checkId(_:))
            .bind(to: idValid)
            .disposed(by: disposeBag)
        
        loginView.passwordTextField.rx.text.orEmpty
            .bind(to: passwordText)
            .disposed(by: disposeBag)
        
        passwordText.map(checkPassword(_:))
            .bind(to: passwordValid)
            .disposed(by: disposeBag)
        
        
        // output
        idValid.subscribe(onNext: {
            if $0 {
                self.loginView.colorBoxView1.backgroundColor = .systemBlue
            } else {
                self.loginView.colorBoxView1.backgroundColor = .systemRed
            }
        })
        .disposed(by: disposeBag)
        
        passwordValid.subscribe(onNext: {
            if $0 {
                self.loginView.colorBoxView2.backgroundColor = .systemBlue
            } else {
                self.loginView.colorBoxView2.backgroundColor = .systemRed
            }
        })
        .disposed(by: disposeBag)
        
        Observable.combineLatest(
            idValid,
            passwordValid,
            resultSelector: { $0 && $1 }
        )
        .subscribe(onNext: {
            self.loginView.loginButton.isEnabled = $0
        })
        .disposed(by: disposeBag)
        
        
        // 로그인 버튼 탭
        loginView.loginButton.rx.tap
            .bind {
                self.view.endEditing(true)
                print("Button Clicked")
            }
            .disposed(by: disposeBag)
        
        /*
        // 이메일 입력
        loginView.idTextField.rx.text
            .orEmpty
            .map(checkId(_:))
            .subscribe(onNext: {
                if $0 {
                    self.loginView.colorBoxView1.backgroundColor = .systemBlue
                } else {
                    self.loginView.colorBoxView1.backgroundColor = .systemRed
                }
            })
            .disposed(by: disposeBag)
        
        // 비밀번호 입력
        loginView.passwordTextField.rx.text
            .orEmpty
            .map(checkPassword(_:))
//            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {
                if $0 {
                    self.loginView.colorBoxView2.backgroundColor = .systemBlue
                } else {
                    self.loginView.colorBoxView2.backgroundColor = .systemRed
                }
            })
            .disposed(by: disposeBag)
        
        // 로그인 버튼 활성화
        // combineLatest : 하나라도 바뀌면 실행
        Observable.combineLatest(
            loginView.idTextField.rx.text.orEmpty.map(checkId(_:)),
            loginView.passwordTextField.rx.text.orEmpty.map(checkPassword(_:)),
            resultSelector: {s1, s2 in s1 && s2}
        )
        .subscribe(onNext: { s in // s1 && s2 결과 값
            self.loginView.loginButton.isEnabled = s
            
        })
        .disposed(by: disposeBag)
         */
    }
    
    private func checkId(_ str: String) -> Bool {
        return str.contains("@") && str.contains(".")
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




