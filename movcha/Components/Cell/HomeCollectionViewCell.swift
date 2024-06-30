//
//  HomeSubCollectionViewCell.swift
//  movcha
//
//  Created by junehee on 6/30/24.
//

import UIKit
import SnapKit

class HomeCollectionViewCell: BaseCollectionViewCell {
    
    let subImage = UIImageView()
    
    override func configureCellHierarchy() {
        contentView.addSubview(subImage)
    }
    
    override func configureCellLayout() {
        subImage.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(160)
            $0.centerY.equalTo(contentView)
        }
    }
    
    override func configureCellUI() {
        subImage.clipsToBounds = true
        subImage.layer.cornerRadius = 10
        subImage.contentMode = .scaleAspectFill
        
        // 임시
        subImage.backgroundColor = .brown
    }
    
    func configureCellData() {
        
    }
    
}
