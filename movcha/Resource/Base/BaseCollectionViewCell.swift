//
//  BaseTableViewCell.swift
//  movcha
//
//  Created by junehee on 6/26/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 계층
    func configureCellHierarchy() { }
    
    // 레이아웃
    func configureCellLayout() { }
    
    // 디자인 & 변하지 않는 데이터
    func configureCellUI() { }
}

