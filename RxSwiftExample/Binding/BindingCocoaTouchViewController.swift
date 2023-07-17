//
//  BindingCocoaTouchViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/17.
//

import UIKit

// Rx 쓰지않은 경우
class BindingCocoaTouchViewController: UIViewController {
    
    let valueLabel = UILabel()
    let valueField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
        valueLabel.text = ""
        valueField.delegate = self
        valueField.becomeFirstResponder()
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

extension BindingCocoaTouchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        let finalText = (currentText as NSString).replacingCharacters(in: range, with: string)
        valueLabel.text = finalText
        
        return true
    }
}
