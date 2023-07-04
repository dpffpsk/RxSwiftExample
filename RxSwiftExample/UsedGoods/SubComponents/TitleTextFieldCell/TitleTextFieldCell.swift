//
//  TitleTextFieldCell.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

// 글 제목 Cell
class TitleTextFieldCell: UITableViewCell {
    let disposeBag = DisposeBag()
    let titleInputField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: TitleTextFieldViewModel) {
        // 텍스트 필드에서 텍스트를 뱉으면 이를 ViewModel에 bind
        titleInputField.rx.text
            .bind(to: viewModel.titleText)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        titleInputField.font = .systemFont(ofSize: 17)
    }
    
    private func layout() {
        contentView.addSubview(titleInputField)
        
        titleInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
}
