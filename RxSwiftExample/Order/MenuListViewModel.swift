//
//  MenuListViewModel.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/21.
//

import Foundation

struct Menu {
    var name: String
    var prcie: Int
    var count: Int
}

class MenuListViewModel {
    let menu: [Menu] = [
        Menu(name: "김밥1", prcie: 100, count: 0),
        Menu(name: "김밥2", prcie: 200, count: 0),
        Menu(name: "김밥3", prcie: 300, count: 0),
        Menu(name: "김밥4", prcie: 400, count: 0),
        Menu(name: "김밥5", prcie: 500, count: 0),
        Menu(name: "김밥6", prcie: 600, count: 0),
        Menu(name: "김밥7", prcie: 700, count: 0),
        Menu(name: "김밥8", prcie: 800, count: 0),
        Menu(name: "김밥9", prcie: 900, count: 0),
        Menu(name: "김밥10", prcie: 1000, count: 0),
        Menu(name: "김밥11", prcie: 1100, count: 0),
        Menu(name: "김밥12", prcie: 1200, count: 0),
        Menu(name: "김밥13", prcie: 1300, count: 0),
        Menu(name: "김밥14", prcie: 1400, count: 0),
    ]
}
