//
//  CitySearcherViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/05/31.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class CitySearcherViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let citySearcherView = CitySearcherView()
    var shownCities = [String]()
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga", "가", "가나", "가나다", "가나다라"] // 고정된 API 데이터

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupConstraints()
        setupAttributes()
        setupBinding()
    }
    
    func setupLayout() {
        view.addSubview(citySearcherView)
    }
    
    func setupConstraints() {
        citySearcherView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupAttributes() {
        citySearcherView.tableView.dataSource = self
    }

    // debounce : 작업을 받으면 해당 시간 뒤에 반환. 기다리는 시간 동안 새로운 값이 들어오면 이전 값은 무시되고 새로운 값으로 다시 시간 카운트
    // distinctUntilChanged : 같은 값이 들어오면 반환해주지 않음.
    // 만약 a -> ab -> a 입력이 들어온다는 가정시. 0.5초가 지나기 전에 a입력 -> b입력 -> b삭제 순서대로 진행하면 처음 요청도 a 다음 요청도 a가 된다. 값이 같지만 똑같은 요청을 하게 되는데, 이와 같이 불필요한 요청을 막기 위해 사용한다.
    func setupBinding() {
        citySearcherView.searchBar.rx.text // RxCocoa의 Observable 속성
            .orEmpty // Optional이 아니도록 만든다
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance) // 0.5초 딜레이(타이핑 후 시간을 주어서 과도한 API 호출 방지)
            .distinctUntilChanged() // 새로운 값이 이전의 값과 같은지 확인
            .filter { !$0.isEmpty } // 빈 값이 아닌 경우만 subscribe
            .subscribe(onNext: { [unowned self] query in
                self.shownCities = self.allCities.filter({ $0.hasPrefix(query) })
                self.citySearcherView.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension CitySearcherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitySearcherCell", for: indexPath)
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = self.shownCities[indexPath.row]
            cell.contentConfiguration = content
        }
        
        return cell
    }
}
