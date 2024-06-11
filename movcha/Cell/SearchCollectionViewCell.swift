//
//  SearchCollectionViewCell.swift
//  movcha
//
//  Created by junehee on 6/12/24.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCellHierarchy()
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellHierarchy() {
        contentView.backgroundColor = Color.Primary.pink
    }
    
    func configureCellUI() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
    }
    
}
