//
//  SideMenuView.swift
//  movcha
//
//  Created by junehee on 6/29/24.
//

import UIKit
import SnapKit

class SideMenuView: BaseView {
    
    let menuTableView = UITableView()
    
    override func configureViewHierarchy() {
        self.addSubview(menuTableView)
    }
    
    override func configureViewLayout() {
        menuTableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureViewUI() {
        backgroundColor = .lightGray
    }
    
}
