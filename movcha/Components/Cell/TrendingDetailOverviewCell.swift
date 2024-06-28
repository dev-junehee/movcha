//
//  TrendingDetailTableViewCell.swift
//  movcha
//
//  Created by junehee on 6/11/24.
//

import UIKit
import SnapKit

class TrendingDetailOverviewCell: BaseTableViewCell {
    
    let overviewLabel = UILabel()
    let overviewBtn = UIButton()
    var isDown = false
    
    var tableView: UITableView?
    
    override func configureCellHierarchy() {
        backgroundColor = .white
        contentView.addSubview(overviewLabel)
        contentView.addSubview(overviewBtn)
    }
    
    override func configureCellLayout() {
        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(16)
            $0.horizontalEdges.equalTo(contentView).inset(20)
            $0.bottom.equalTo(overviewBtn.snp.top)
        }
        
        overviewBtn.snp.makeConstraints {
            $0.top.equalTo(overviewLabel.snp.bottom).offset(50)
            $0.horizontalEdges.equalTo(contentView).inset(20)
            $0.bottom.equalTo(contentView).inset(6)
        }
    }
    
    override func configureCellUI() {
        overviewLabel.font = Constants.Font.body
        overviewLabel.numberOfLines = 2
        overviewBtn.setImage(Constants.SystemImage.down, for: .normal)
        overviewBtn.tintColor = Constants.Color.Primary.pink
    }
    
    func configreCellData(data: String) {
        overviewLabel.text = data
    }
    
    func configureHandler() {
        overviewBtn.addTarget(self, action: #selector(overviewBtnClicked), for: .touchUpInside)
    }
    
    @objc func overviewBtnClicked() {
        isDown.toggle()
        
        if isDown {
            overviewLabel.numberOfLines = 0
            overviewBtn.setImage(Constants.SystemImage.up, for: .normal)
        } else {
            overviewLabel.numberOfLines = 2
            overviewBtn.setImage(Constants.SystemImage.down, for: .normal)
        }
        
        tableView?.reloadData()
    }
}
