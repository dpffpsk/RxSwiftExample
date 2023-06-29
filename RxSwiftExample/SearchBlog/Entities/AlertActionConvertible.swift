//
//  AlertActionConvertible.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/29.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
