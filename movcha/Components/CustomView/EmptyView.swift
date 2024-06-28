//
//  SearchEmptyView.swift
//  movcha
//
//  Created by junehee on 6/28/24.
//

import UIKit
import SnapKit

class EmptyView: BaseView {
    
    let emptyView = UIStackView()
    let emptyLabel = UILabel()
    
    override func configureViewHierarchy() {
        emptyView.addArrangedSubview(emptyLabel)
        addSubview(emptyView)
    }
    
    override func configureViewLayout() {
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        emptyView.axis = .vertical
        emptyView.spacing = 8
    }
    
    override func configureViewUI() {
        backgroundColor = Constants.Color.Primary.white
        emptyLabel.font = Constants.Font.bodyBold
        emptyLabel.text = Constants.Text.Search.empty
        emptyLabel.textColor = Constants.Color.Primary.darkGray
        emptyLabel.textAlignment = .center
    }
    
}
