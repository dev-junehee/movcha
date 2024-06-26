//
//  HomeView.swift
//  movcha
//
//  Created by junehee on 6/26/24.
//

import UIKit
import SnapKit

class HomeView: BaseView {
    
    let mainTitle = UILabel()
    
    override func configureViewHierarchy() {
        self.addSubview(mainTitle)
    }
    
    override func configureViewLayout() {
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(50)
        }
    }
    
    override func configureViewUI() {
        mainTitle.font = Constants.Font.title
        mainTitle.text = Constants.Text.Title.home
    }
}
