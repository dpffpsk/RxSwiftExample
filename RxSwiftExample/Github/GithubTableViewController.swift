//
//  GithubTableViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/27.
//

import UIKit
import RxSwift
import RxCocoa

class GithubTableViewController: UITableViewController {
    private let organization = "Apple"
    private let repositories = BehaviorSubject<[GitRepository]>(value: [])
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = organization + "Repositories"
        
        // 당겨서 새로고침
        self.refreshControl = UIRefreshControl()
        let refreshControl = self.refreshControl!
        refreshControl.backgroundColor = .white
        refreshControl.tintColor = .darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        tableView.register(GithubListTableViewCell.self, forCellReuseIdentifier: "GithubListTableViewCell")
        tableView.rowHeight = 140
    }

    @objc func refresh() {
        DispatchQueue.global(qos: .background).async {[weak self] in
            guard let self = self else { return }
            self.fetchRepositories(of: self.organization)
        }
    }
    
    func fetchRepositories(of organization: String) {
        // from : Array만 받음
        Observable.from([organization])
            .map { organization -> URL in
                return URL(string: "https://api.github.com/orgs/\(organization)/repos")!
            }
            .map { url -> URLRequest in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                return request
            }
            .flatMap { reqeust -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: reqeust)
            }
            .filter { response, _ in
                return 200..<300 ~= response.statusCode
            }
            .map { _, data -> [[String: Any]] in
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                      let result = json as? [[String: Any]] else {
                    return []
                }
                return result
            }
            .filter { result in
                // result 빈 배열([])일 경우 거르기
                return result.count > 0
            }
            .map { objects in
                print("======objects : \(objects)")
                
                // Dictionary에서 GitRepository의 엔티티로 바꿔줌
                // compactMap을 사용해서 nil 값 제거
                return objects.compactMap { dic -> GitRepository? in
                    guard let id = dic["id"] as? Int,
                          let name = dic["name"] as? String,
                          let description = dic["description"] as? String,
                          let stargazersCount = dic["stargazers_count"] as? Int,
                          let language = dic["language"] as? String else {
                        return nil
                    }
                    
                    return GitRepository(id: id, name: name, description: description, stargazersCount: stargazersCount, language: language)
                }
            } // Observable<[GitRepository]>
            .subscribe { [weak self] newRepositories in
                self?.repositories.onNext(newRepositories)
                print("=============repo : \(newRepositories)")
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl?.endRefreshing()
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try repositories.value().count
        } catch {
            // nil일 경우 처리
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GithubListTableViewCell", for: indexPath) as? GithubListTableViewCell else { return UITableViewCell() }
        
        var currentRepo: GitRepository? {
            do {
                return try repositories.value()[indexPath.row]
            } catch {
                return nil
            }
        }
        
        cell.repository = currentRepo
        
        return cell
    }
}
