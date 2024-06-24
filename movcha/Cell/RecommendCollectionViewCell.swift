//
//  RecomendCollectionViewCell.swift
//  movcha
//
//  Created by junehee on 6/24/24.
//

import UIKit
import SnapKit

class RecommendCollectionViewCell: UICollectionViewCell {
    
    let posterView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCellHierarchy() {
        contentView.addSubview(posterView)
    }
    
    private func configureCellLayout() {
        posterView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
    private func configureCellUI() {
        posterView.backgroundColor = Constants.Color.Primary.pink
        posterView.clipsToBounds = true
        posterView.layer.cornerRadius = 10
        posterView.contentMode = .scaleAspectFill
    }
    
}
