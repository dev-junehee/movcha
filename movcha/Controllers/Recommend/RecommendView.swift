//
//  RecommendView.swift
//  movcha
//
//  Created by junehee on 6/26/24.
//

import UIKit

class RecommendView: BaseView {
    
    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = 230
        view.separatorStyle = .none
        return view
    }()
    
    let searchTitleLabel = {
        let view = UILabel()
        view.font = Constants.Font.title
        return view
    }()
    
    let searchSubLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.textColor = Constants.Color.Primary.darkGray
        view.baselineAdjustment = .alignBaselines
        return view
    }()
    
    override func configureHierarchy() {
        let subViews = [tableView, searchTitleLabel, searchSubLabel]
        subViews.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
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

}
