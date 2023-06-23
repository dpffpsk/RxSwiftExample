//
//  OrderViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/20.
//

import UIKit
import RxCocoa
import RxSwift

class OrderViewController: UIViewController {

    let orderView = OrderView()
    let viewModel = MenuListViewModel()
    let disposeBag = DisposeBag()
    let menuModel = Observable.of(MenuListViewModel().menu.map{ $0 })
    var totalPrice = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(orderView)
    }
    
    private func setupConstraints() {
        orderView.translatesAutoresizingMaskIntoConstraints = false
        orderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        orderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        orderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        orderView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupBinding() {
        
        menuModel.bind(to: orderView.menuTableView.rx.items(cellIdentifier: OrderTableViewCell.identifier, cellType: OrderTableViewCell.self)) { index, element, cell in
            
            cell.menuNameLabel.text = self.viewModel.menu[index].name
            cell.priceLabel.text = String(self.viewModel.menu[index].prcie)
        }
        .disposed(by: disposeBag)
        
        orderView.menuTableView.rx
            .itemSelected
            .withUnretained(self)
            .subscribe(onNext: { owner, indexPath in
                // 선택셀 해제
                owner.orderView.menuTableView.deselectRow(at: indexPath, animated: true)
            }).disposed(by: disposeBag)
    }

    
}
