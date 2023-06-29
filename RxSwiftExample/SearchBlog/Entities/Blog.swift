//
//  Blog.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/29.
//

import Foundation

struct Blog: Decodable {
    let documents: [Document]
}

struct Document: Decodable {
    let title: String?
    let name: String?
    let thumbnail: String?
    let datetime: Date?
    
    enum CodingKeys: String, CodingKey {
        case title, thumbnail, datetime
        case name = "blogname"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try? values.decode(String?.self, forKey: .title)
        self.name = try? values.decode(String?.self, forKey: .name)
        self.thumbnail = try? values.decode(String?.self, forKey: .thumbnail)
        self.datetime = Date.parse(values, key: .datetime)
    }
    
}

// json에 date라는 타입이 없기 때문에 custom
extension Date {
    // string -> date
    static func parse<K: CodingKey>(_ values: KeyedDecodingContainer<K>, key: K) -> Date? {
        guard let dateString = try? values.decode(String.self, forKey: key),
            let date = from(dateString: dateString) else {
            return nil
        }
        
        return date
    }
    
    static func from(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        if let date = dateFormatter.date(from: dateString) {
            return date
        }

        return nil
    }
}

