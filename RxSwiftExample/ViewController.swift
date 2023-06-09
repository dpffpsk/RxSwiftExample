//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/05/31.
//

import UIKit

class ViewController: UIViewController {

    let menuList = ["CitySearcher", "CircleView", "IssueListView", "LoginView"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicTableViewCell", for: indexPath)
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = self.menuList[indexPath.row]
            cell.contentConfiguration = content
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("index 0")
            let citySearcherVC = CitySearcherViewController()
            self.navigationController?.pushViewController(citySearcherVC, animated: true)
        case 1:
            print("index 1")
            let circleVC = CircleViewController()
            self.navigationController?.pushViewController(circleVC, animated: true)
        case 2:
            print("index 2")
            let issueListVC = IssueListViewController()
            self.navigationController?.pushViewController(issueListVC, animated: true)
        case 3:
            print("index 3")
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: true)
        default:
            print("default")
        }
    }
}
