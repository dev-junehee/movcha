//
//  TrendingDetailView.swift
//  movcha
//
//  Created by junehee on 6/28/24.
//

import UIKit
import SnapKit

class TrendingDetailView: BaseView {
    
    let detailImgView = UIImageView()
    
    let titleLabel = UILabel()
    let posterImgView = UIImageView()
    
    let detailTableView = UITableView()
    
    override func configureViewHierarchy() {
        let subView = [detailImgView, titleLabel, posterImgView, detailTableView]
        subView.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureViewLayout() {
        detailImgView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(detailImgView.snp.top).offset(16)
            make.leading.equalTo(detailImgView.snp.leading).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        
        posterImgView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(detailImgView.snp.leading).offset(16)
            make.width.equalTo(100)
            make.bottom.equalTo(detailImgView.snp.bottom)
        }
        
        detailTableView.snp.makeConstraints { make in
            make.top.equalTo(detailImgView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
