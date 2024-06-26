//
//  HomeView.swift
//  movcha
//
//  Created by junehee on 6/26/24.
//

import UIKit
import SnapKit

class HomeView: BaseView {
    
    let mainTitle = {
        let label = UILabel()
        label.font = Constants.Font.title
        label.text = Constants.Text.Title.home
        return label
    }()
    
    override func configureHierarchy() {
        self.addSubview(mainTitle)
    }
    
    override func configureLayout() {
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(50)
        }
    }
}
