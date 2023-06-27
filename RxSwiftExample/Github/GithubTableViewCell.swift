//
//  GithubListTableViewCell.swift
//  RxSwiftExample
//
//  Created by jiweon.lee on 2023/06/27.
//

import UIKit
import SnapKit

class GithubListTableViewCell: UITableViewCell {
    var repository: GitRepository?
    
    // UI
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let starImageView = UIImageView()
    let starLabel = UILabel()
    let languageLabel = UILabel()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [
            nameLabel, descriptionLabel, starImageView, starLabel, languageLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
}
