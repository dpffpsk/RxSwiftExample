//
//  SearchBlogViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/28.
//

import UIKit
import RxSwift
import RxCocoa

class SearchBlogViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let listView = BlogListView()
    let searchBar = SearchBar()
    
    // AlertAction 이벤트 받는 변수
    let alertActionTapped = PublishRelay<AlertAction>()
    
    // init : 데이터 관련 초기화할 때
    // viewDidLoad : 뷰 관련 초기화할 때
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind()
        attribute()
        layout()
        // badget
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        let alertSheetForSorting = listView.headerView.sortButtonTapped
            .map { _ -> Alert in
                return (title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
            }
        
//        alertSheetForSorting
//            .asSignal(onErrorSignalWith: .empty())
//            .flatMapLatest { <#(title: String?, message: String?, actions: [AlertAction], style: UIAlertController.Style)#> in
//                <#code#>
//            }
    }
    
    private func attribute() {
        title = "블로그 검색"
        view.backgroundColor = .white
    }
    
    private func layout() {
        [searchBar, listView].forEach { view.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        listView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// 필터뷰의 버튼 눌렀을 때 나오는 Alert(BottomSheet)
extension SearchBlogViewController {
    typealias Alert = (title: String?, message: String?, actions: [AlertAction], style: UIAlertController.Style)

    enum AlertAction: AlertActionConvertible {
        case title, datetime, cancel
        case confirm
        
        var title: String {
            switch self {
            case .title:
                return "Title"
            case .datetime:
                return "Datetime"
            case .cancel:
                return "취소"
            case .confirm:
                return "확인"
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case .title, .datetime:
                return .default
            case .cancel, .confirm:
                return .cancel
            }
        }
    }
    
    func presentAlertController<Action: AlertActionConvertible>(_ alertController: UIAlertController, actions: [Action]) -> Signal<Action> {
        if actions.isEmpty { return .empty() }
        return Observable
            .create { [unowned self] observer in
                for action in actions {
                    alertController.addAction(
                        UIAlertAction(
                            title: action.title,
                            style: action.style,
                            handler: { _ in
                                observer.onNext(action)
                                observer.onCompleted()
                            }
                        )
                    )
                }
                self.present(alertController, animated: true, completion: nil)
                
                return Disposables.create {
                    alertController.dismiss(animated: true, completion: nil)
                }
            }
            .asSignal(onErrorSignalWith: .empty())
        }
}
