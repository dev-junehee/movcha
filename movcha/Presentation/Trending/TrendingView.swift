//
//  TrendingView.swift
//  movcha
//
//  Created by junehee on 6/28/24.
//

import UIKit
import SnapKit

class TrendingView: BaseView {
    
    private let mainTitle = UILabel()
    let trendingTableView = UITableView()
    
    override func configureViewHierarchy() {
        let subviews = [mainTitle, trendingTableView]
        subviews.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureViewLayout() {
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(50)
        }
        
        trendingTableView.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureViewUI() {
        mainTitle.text = Constants.Text.Title.trending
        mainTitle.font = .systemFont(ofSize: 40, weight: .black)
    }
    
}
