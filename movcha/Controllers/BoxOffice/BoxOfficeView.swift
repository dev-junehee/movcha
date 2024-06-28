//
//  BoxOfficeView.swift
//  movcha
//
//  Created by junehee on 6/26/24.
//

import UIKit
import SnapKit

class BoxOfficeView: BaseView {
    
    // 메인 타이틀
    let mainTitle = UILabel()
    
    // 검색창 영역
    let searchAreaStack = UIStackView()
    let dateTextField = UITextField()
    let searchButton = UIButton()
    
    // 박스오피스 테이블 뷰
    let tableView = UITableView()
    
    override func configureViewHierarchy() {
        let searchAreaViews = [dateTextField, searchButton]
        searchAreaViews.forEach {
            searchAreaStack.addArrangedSubview($0)
        }
        
        let subviews = [mainTitle, searchAreaStack, tableView]
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
        
        searchAreaStack.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(8)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(40)
        }
        searchAreaStack.spacing = 8
        searchAreaStack.alignment = .fill
        
        dateTextField.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(searchAreaStack)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(searchAreaStack)
            make.width.equalTo(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchAreaStack.snp.bottom).offset(12)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureViewUI() {
        mainTitle.font = Constants.Font.title
        
        dateTextField.borderStyle = .none
        dateTextField.layer.borderWidth = 1
        dateTextField.layer.cornerRadius = 10
        dateTextField.layer.borderColor = Constants.Color.Primary.gray6.cgColor
        dateTextField.font = Constants.Font.small
        dateTextField.keyboardType = .numberPad
        dateTextField.addPadding(type: .left, amount: 12)
        
        searchButton.backgroundColor = Constants.Color.Primary.pink
        searchButton.layer.cornerRadius = 10
        searchButton.titleLabel?.font = Constants.Font.bodyBold
        
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
    }
}
