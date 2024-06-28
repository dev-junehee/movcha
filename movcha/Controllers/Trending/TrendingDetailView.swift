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
        detailImgView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(detailImgView.snp.top).offset(16)
            $0.horizontalEdges.equalTo(detailImgView).inset(16)
            $0.height.equalTo(36)
        }
        
        posterImgView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(detailImgView.snp.leading).offset(16)
            $0.width.equalTo(100)
            $0.bottom.equalTo(detailImgView.snp.bottom)
        }
        
        detailTableView.snp.makeConstraints {
            $0.top.equalTo(detailImgView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureViewUI() {
        detailImgView.alpha = 0.7
        detailImgView.contentMode = .scaleAspectFill
        titleLabel.font = Constants.Font.subTitle
        titleLabel.shadowOffset = CGSize(width: 0.0, height: 1.0)
        titleLabel.shadowColor = Constants.Color.Primary.gray2
        titleLabel.layer.shadowOpacity = 0.3
    }
}
