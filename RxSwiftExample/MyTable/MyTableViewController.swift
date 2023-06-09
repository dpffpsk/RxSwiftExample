//
//  MyTableViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/19.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class MyTableViewController: UIViewController {

    let tableView = UITableView()
    let disposeBag = DisposeBag()
    
    var sections = [
        MyTable(header: "A", items: [1, 2, 3, 4]),
        MyTable(header: "B", items: [1, 2])
    ]
    
    // Table DataSource
    // RxDataSources는 RxSwift 용 UITableView와 UICollectionView의 DataSources 관련 라이브러리
    var dataSource: RxTableViewSectionedReloadDataSource<MyTable>!
    
    // Relay : Subject와 다르게 Next 이벤트만 받는다(completed와 error 받지 X). 그래서 Subject와 달리 종료되지 않는다. 구독자가 dispose되기까지 계속 이벤트를 처리한다.(= 주로 종료없이 지속되는 UI 이벤트를 처리하는데 사용) 이벤트를 전달하기 위해서는 onNext()가 아니라 accept 메소드를 사용한다.
    var relay: BehaviorRelay<[MyTable]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
        setupLayout()
        setupConstraints()
    }
    
    func setupLayout() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
        
        // DataSource 정의
        let dataSource = RxTableViewSectionedReloadDataSource<MyTable>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath)
                cell.selectionStyle = .none

                if #available(iOS 14.0, *) {
                    var content = cell.defaultContentConfiguration()
                    content.text = "Item \(item)"
                    cell.contentConfiguration = content
                }
                return cell
            })

        // 섹션 헤더
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
        
        // 오른쪽 인디케이터 문자
        dataSource.sectionIndexTitles = { ds in
            return ds.sectionModels.map { $0.header }
        }
        
        // 인디테이커 문자와 인덱스 참조 가능
        dataSource.sectionForSectionIndexTitle = { ds, title, index in
            print(title)
            print(index)
            return ds.sectionModels.map { $0.header }.firstIndex(of: title) ?? 0
        }
        
        self.dataSource = dataSource
        
        // delegate 선언
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        // input
        relay
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // output
        // Subject onNext == Relay accept
        relay.accept(sections)
    }
}

extension MyTableViewController: UITableViewDelegate {
    // 셀마다 크기 다르게
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = dataSource?[indexPath], dataSource?[indexPath.section] != nil else { return 0.0 }
        
        return CGFloat(40 + item * 10)
    }
}
