//
//  LoginView.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/08.
//

import UIKit
import SnapKit
import Then

class LoginView: UIView {

    lazy var idTextField = UITextField(frame: .zero)
    lazy var passwordTextField = UITextField(frame: .zero)
    lazy var colorBoxView1 = UIView().then {
        $0.backgroundColor = .blue
    }
    lazy var colorBoxView2 = UIView().then {
        $0.backgroundColor = .blue
    }
    
    lazy var landscapeStackView1 = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.distribution = .fill
        $0.alignment = .center
    }
    
    lazy var landscapeStackView2 = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.distribution = .fill
        $0.alignment = .center
    }
    
    lazy var portraitStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fillEqually
    }
    

    lazy var loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
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
        
        addSubview(portraitStackView)
        addSubview(loginButton)

        portraitStackView.addArrangedSubview(landscapeStackView1)
        portraitStackView.addArrangedSubview(landscapeStackView2)
        
        landscapeStackView1.addArrangedSubview(idTextField)
        landscapeStackView1.addArrangedSubview(colorBoxView1)
        
        landscapeStackView2.addArrangedSubview(passwordTextField)
        landscapeStackView2.addArrangedSubview(colorBoxView2)
    }
    
    func setupConstraints() {
        // horizontal stackview1
        idTextField.snp.makeConstraints {
            $0.top.equalTo(landscapeStackView1.snp.top).offset(10)
            $0.leading.equalTo(landscapeStackView1.snp.leading)
            $0.bottom.equalTo(landscapeStackView1.snp.bottom).offset(10)
        }
        
        colorBoxView1.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(20)
        }
        
        landscapeStackView1.snp.makeConstraints {
            $0.top.equalTo(portraitStackView.snp.top)
            $0.leading.equalTo(portraitStackView.snp.leading)
            $0.trailing.equalTo(portraitStackView.snp.trailing)
        }
        
        // horizontal stackview2
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(landscapeStackView2.snp.top).offset(10)
            $0.leading.equalTo(landscapeStackView2.snp.leading)
            $0.bottom.equalTo(landscapeStackView2.snp.bottom).offset(10)
        }
        
        colorBoxView2.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(20)
        }
        
        landscapeStackView2.snp.makeConstraints {
            $0.leading.equalTo(portraitStackView.snp.leading)
            $0.trailing.equalTo(portraitStackView.snp.trailing)
            $0.bottom.equalTo(portraitStackView.snp.bottom)
        }
        
        // vertical stackview
        portraitStackView.snp.makeConstraints {
            $0.top.leading.equalTo(self.safeAreaLayoutGuide).offset(50)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-50)
        }
        
        // button
        loginButton.snp.makeConstraints {
            $0.top.equalTo(portraitStackView.snp.bottom).offset(30)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(50)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-50)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(500)
            $0.height.equalTo(35)
        }
    }
}
