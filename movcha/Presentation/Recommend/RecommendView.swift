//
//  RecommendView.swift
//  movcha
//
//  Created by junehee on 6/26/24.
//

import UIKit
import SnapKit

class RecommendView: BaseView {
    
    // 추천 콘텐츠 테이블 뷰
    let tableView = UITableView()
    
    // 검색 결과-콘텐츠명, 서브텍스트
    let searchTitleLabel = UILabel()
    let searchSubLabel = UILabel()
    
    override func configureViewHierarchy() {
        let subViews = [tableView, searchTitleLabel, searchSubLabel]
        subViews.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureViewLayout() {
        searchTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(40)
        }
        
        searchSubLabel.snp.makeConstraints {
            $0.top.trailing.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.leading.equalTo(searchTitleLabel.snp.trailing).offset(8)
            $0.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchSubLabel.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureViewUI() {
        tableView.rowHeight = 230
        tableView.separatorStyle = .none
        
        searchTitleLabel.font = Constants.Font.title
        
        searchSubLabel.font = Constants.Font.body
        searchSubLabel.textColor = Constants.Color.Primary.darkGray
        searchSubLabel.baselineAdjustment = .alignBaselines
    }

}
