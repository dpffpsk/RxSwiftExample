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

        // 테이블뷰 셀 정의
        menuModel.bind(to: orderView.menuTableView.rx.items(cellIdentifier: OrderTableViewCell.identifier, cellType: OrderTableViewCell.self)) { index, element, cell in
            
            print("index : \(index)")
            print("element : \(element)")
            print("cell : \(cell)")
            
            cell.menuNameLabel.text = self.viewModel.menu[index].name
            cell.priceLabel.text = String(self.viewModel.menu[index].prcie)
            
            self.tappedButton(menu: element, cell: cell)
        }
        .disposed(by: disposeBag)
        
        // 셀 tap
        orderView.menuTableView.rx
            .itemSelected
            .withUnretained(self)
            .subscribe(onNext: { owner, indexPath in
                // 선택셀 해제
                owner.orderView.menuTableView.deselectRow(at: indexPath, animated: true)
            }).disposed(by: disposeBag)
        
        // ORDER 버튼
    }
    
    private func tappedButton(menu: Menu, cell: OrderTableViewCell) {
        cell.plusButton.rx
            .tap
            .bind(onNext: { _ in
                self.totalPrice += menu.prcie
                self.orderView.totalLabel.text = self.numberFormatter(number: self.totalPrice)
            })
            .disposed(by: disposeBag)
        
        cell.minusButton.rx
            .tap
            .bind(onNext: { _ in
                self.totalPrice -= menu.prcie
                if self.totalPrice < 0 {
                    self.totalPrice = 0
                }
                self.orderView.totalLabel.text = self.numberFormatter(number: self.totalPrice)
            })
            .disposed(by: disposeBag)
    }
    
    private func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(for: number)!
    }
}
