//
//  HomeView.swift
//  movcha
//
//  Created by junehee on 6/26/24.
//

import UIKit
import SnapKit

class HomeView: BaseView {
    
    // 메인 타이틀
    private let mainTitle = UILabel()
    let tableView = UITableView()
    
    override func configureViewHierarchy() {
        let subView = [mainTitle, tableView]
        subView.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureViewLayout() {
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureViewUI() {
        mainTitle.font = Constants.Font.title
        mainTitle.text = Constants.Text.Title.home
    }
}
