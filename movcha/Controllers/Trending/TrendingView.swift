//
//  TrendingView.swift
//  movcha
//
//  Created by junehee on 6/28/24.
//

import UIKit
import SnapKit

class TrendingView: BaseView {
    
    let mainTitle = UILabel()
    let trendingTableView = UITableView()
    
    override func configureViewHierarchy() {
        let subviews = [mainTitle, trendingTableView]
        subviews.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureViewLayout() {
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(50)
        }
        
        trendingTableView.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureViewUI() {
        mainTitle.font = .systemFont(ofSize: 40, weight: .black)
    }
    
}
