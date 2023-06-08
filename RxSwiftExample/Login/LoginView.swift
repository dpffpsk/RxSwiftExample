//
//  LoginView.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/08.
//

import UIKit
import SnapKit

class LoginView: UIView {

    lazy var idTextField = UITextField(frame: .zero)
    lazy var passwordTextField = UITextField(frame: .zero)
    lazy var colorBoxView1 = UIView(frame: .zero)
    lazy var colorBoxview2 = UIView(frame: .zero)
    lazy var landscapeTextField1 = UIStackView(frame: .zero)
    lazy var landscapeTextField2 = UIStackView(frame: .zero)
    lazy var portraitTextField = UIStackView(frame: .zero)
    lazy var loginButton = UIButton(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        landscapeTextField1.addSubview(idTextField)
        landscapeTextField1.addSubview(colorBoxView1)
        landscapeTextField2.addSubview(passwordTextField)
        landscapeTextField2.addSubview(colorBoxview2)
    
        portraitTextField.addSubview(landscapeTextField1)
        portraitTextField.addSubview(landscapeTextField2)
    }
    
    func setupConstraints() {
        
    }
}
