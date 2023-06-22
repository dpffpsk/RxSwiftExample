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
        Menu(name: "워니김밥", prcie: 100, count: 0),
        Menu(name: "참치김밥", prcie: 200, count: 0),
        Menu(name: "땡초김밥", prcie: 300, count: 0),
        Menu(name: "마늘떡볶이", prcie: 400, count: 0),
        Menu(name: "라볶이", prcie: 500, count: 0),
        Menu(name: "쫄면", prcie: 600, count: 0),
        Menu(name: "오므라이스", prcie: 700, count: 0),
        Menu(name: "우동", prcie: 800, count: 0),
        Menu(name: "김치치즈볶음밥", prcie: 900, count: 0),
        Menu(name: "물", prcie: 1000, count: 0),
        Menu(name: "단무지", prcie: 1100, count: 0),
        Menu(name: "고구마치즈돈까스", prcie: 1200, count: 0),
        Menu(name: "어린이돈까스", prcie: 1300, count: 0),
        Menu(name: "만수르정식", prcie: 1400, count: 0),
    ]
}
