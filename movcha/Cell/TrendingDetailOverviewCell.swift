//
//  TrendingDetailTableViewCell.swift
//  movcha
//
//  Created by junehee on 6/11/24.
//

import UIKit
import SnapKit

class TrendingDetailOverviewCell: UITableViewCell {
    
    let overviewLabel = UILabel()
    let overviewBtn = UIButton()
    var isDown = false
    
    var tableView: UITableView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()
        configureHandler()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellHierarchy() {
        backgroundColor = .white
        
        contentView.addSubview(overviewLabel)
        contentView.addSubview(overviewBtn)
    }
    
    func configureCellLayout() {
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.bottom.equalTo(overviewBtn.snp.top)
        }
        
        overviewBtn.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView)
            make.height.equalTo(20)
        }
        
    }
    
    func configureCellUI() {
//        overviewLabel.backgroundColor = .lightGray
        overviewLabel.font = .systemFont(ofSize: 14)
        overviewLabel.numberOfLines = 2
        
//        overviewBtn.backgroundColor = .darkGray
        
        overviewBtn.setImage(Constants.SystemImage.down, for: .normal)
    }
    
    func configreCellData(data: String) {
        overviewLabel.text = data
    }
    
    func configureHandler() {
        overviewBtn.addTarget(self, action: #selector(overviewBtnClicked), for: .touchUpInside)
    }
    
    @objc func overviewBtnClicked() {
        print(#function)
        print(isDown)
        isDown.toggle()
        
        if isDown {
            overviewLabel.numberOfLines = 0
            overviewBtn.setImage(Constants.SystemImage.up, for: .normal)
        } else {
            overviewLabel.numberOfLines = 2
            overviewBtn.setImage(Constants.SystemImage.down, for: .normal)
        }
        
        print(isDown)
        tableView?.reloadData()
    }
}
