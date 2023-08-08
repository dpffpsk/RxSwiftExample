//
//  MVVMTestViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/08/08.
//

import UIKit
import RxSwift

class MVVMTestViewModel {
    var users = BehaviorSubject(value: [User]())
    
    // 데이터 불러오기
    func fetchUsers() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode([User].self, from: data)
                self.users.on(.next(responseData))
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
//    // 추가
//    func addUser(user: User) {
//        
//    }
//    
//    // 삭제
//    func deleteUser(index: Int) {
//        guard var users = try? users.value() else { return }
//        users.remove(at: index)
//        self.users.onNext(users)
//    }
//    
//    // 수정
//    func editUser(title: String, index: Int) {
//        
//    }
}
