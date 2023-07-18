//
//  Scene.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/07/18.
//

import UIKit

// 뷰 정의
enum Scene {
    case list(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}

extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .list(let viewModel):
            var listVC = MemoListViewController()
            listVC.bind(viewModel: viewModel)
            
            return listVC
        case .detail(let viewModel):
            var detailVC = MemoDetailViewController()
            detailVC.bind(viewModel: viewModel)
            
            return detailVC
        case .compose(let viewModel):
            var composeVC = MemoComposeViewController()
            composeVC.bind(viewModel: viewModel)
            
            return composeVC
        default:
            return UIViewController()
        }
    }
}
