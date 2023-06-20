//
//  SimpleLoginView.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/20.
//

import UIKit
import SnapKit
import Then

class SimpleLoginView: UIView {
    lazy var titleLabel = UILabel().then {
        $0.textColor = .cyan
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.text = "LOGIN🙃"
    }

    lazy var emailTextField = UITextField().then {
        $0.placeholder = "이메일을 입력해주세요."
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.layer.borderColor = UIColor.systemCyan.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 15
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        $0.leftViewMode = .always
    }
    
    lazy var passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요."
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.layer.borderColor = UIColor.systemCyan.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 15
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        $0.leftViewMode = .always
    }
    
    lazy var loginButton = UIButton().then {
        $0.setTitle("Login", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = .cyan
        $0.layer.cornerRadius = 15
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(10)
            $0.leading.equalTo(emailTextField.snp.leading)
            $0.trailing.equalTo(emailTextField.snp.trailing)
            $0.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(50)
            $0.leading.trailing.equalTo(emailTextField)
        }
    }
}
