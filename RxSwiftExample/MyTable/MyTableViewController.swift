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
    var dataSource: RxTableViewSectionedReloadDataSource<MyTable>!
    var subject: BehaviorRelay<[MyTable]> = BehaviorRelay(value: [])
    
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
                
                print("==========dataSource : \(dataSource)")
                print("==========tableView : \(tableView)")
                print("==========indexPath : \(indexPath)")
                print("==========item : \(item)")
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath)
                cell.selectionStyle = .none

                if #available(iOS 14.0, *) {
                    var content = cell.defaultContentConfiguration()
                    print("==== \(indexPath)")
//                    content.text = self.shownCities[indexPath.row]
                    cell.contentConfiguration = content
                }
                return cell
            })
        
        subject.accept(sections)
        
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
        
        dataSource.sectionIndexTitles = { ds in
            return ds.sectionModels.map { $0.header }
        }
        
        dataSource.sectionForSectionIndexTitle = { ds, title, index in
            print(title)
            print(index)
            return ds.sectionModels.map { $0.header }.firstIndex(of: title) ?? 0
        }
        
        
        self.dataSource = dataSource
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        // binding
        subject
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension MyTableViewController: UITableViewDelegate {

}
