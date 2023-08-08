//
//  MVVMTestViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/08/08.
//

import UIKit
import RxSwift
import RxDataSources

class MVVMTestViewModel {
//    var users = BehaviorSubject(value: [User]())
    var users = BehaviorSubject(value: [SectionModel(model: "", items: [User]())])
    
    // 데이터 불러오기
    func fetchUsers() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode([User].self, from: data)
//                self.users.on(.next(responseData))
                let sectionUser = SectionModel(model: "first", items: [User(userID: 0, id: 1, title: "wonny", body: "Look at THAT!!!!!!!!")])
                let secondSection = SectionModel(model: "second", items: responseData)
                self.users.onNext([sectionUser, secondSection])
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    /*
    // 추가
    func addUser(user: User) {
        guard var users = try? users.value() else { return }
        users.insert(user, at: 0)
        self.users.onNext(users)
    }
    
    // 삭제
    func deleteUser(index: Int) {
        guard var users = try? users.value() else { return }
        users.remove(at: index)
        self.users.onNext(users)
    }
    
    // 수정
    func editUser(title: String, index: Int) {
        guard var users = try? users.value() else { return }
        users[index].title = title
        self.users.onNext(users)
    }
     */
    
    
    // 추가
    func addUser(user: User) {
        guard var sections = try? users.value() else { return }
        var currentSection = sections[0]
        currentSection.items.append(User(userID: 2, id: 32, title: "New Data", body: "body"))
        sections[0] = currentSection
        self.users.onNext(sections)
    }
    
    // 삭제
    func deleteUser(indexPath: IndexPath) {
        guard var sections = try? users.value() else { return }
        var currentSection = sections[indexPath.section]
        currentSection.items.remove(at: indexPath.row)
        sections[indexPath.section] = currentSection
        self.users.onNext(sections)
    }
    
    // 수정
    func editUser(title: String, indexPath: IndexPath) {
        guard var sections = try? users.value() else { return }
        var currentSection = sections[indexPath.section]
        currentSection.items[indexPath.row].title = title
        sections[indexPath.section] = currentSection
        self.users.onNext(sections)
    }
    
}
