//
//  BlogListView.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/28.
//

import UIKit
import RxSwift
import RxCocoa

class BlogListView: UITableView {
    let disposeBag = DisposeBag()
    
    // 디바이스 별 크기에 맞게 헤더뷰 설정
    let headerView = FilterView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 50)))
    
    // SearchBlogViewController -> BlogList
    // 네트워크 작업을 통해 받아 온 값 -> 뷰로 가져옴
    // 이 때 받아올 수 있는 이벤트 값
    let cellData = PublishSubject<[BlogListCellData]>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        bind()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        // cellForRowAt함수를 Rx로 표현함
        cellData
            .asDriver(onErrorJustReturn: []) // 에러나면 빈 배열 전달
            .drive(self.rx.items) { tv, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = tv.dequeueReusableCell(withIdentifier: "BlogListCell", for: index) as! BlogListCell
                cell.setData(data)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.backgroundColor = .white
        self.register(BlogListCell.self, forCellReuseIdentifier: "BlogListCell")
        self.separatorStyle = .singleLine // 셀 간 구분선
        self.rowHeight = 100
        self.tableHeaderView = headerView
    }
}
