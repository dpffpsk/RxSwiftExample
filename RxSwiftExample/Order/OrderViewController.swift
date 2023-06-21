//
//  OrderViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/20.
//

import UIKit

class OrderViewController: UIViewController {

    let orderView = OrderView()
    let viewModel = MenuListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
