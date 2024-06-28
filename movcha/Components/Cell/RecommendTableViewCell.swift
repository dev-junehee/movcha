//
//  RecommendTableViewCell.swift
//  movcha
//
//  Created by junehee on 6/25/24.
//

import UIKit
import SnapKit

class RecommendTableViewCell: BaseTableViewCell {
    
    let titleLabel = UILabel()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    static func layout() -> UICollectionViewLayout {
        let  layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func configureCellHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configureCellLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView).inset(20)
            $0.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    
    override func configureCellUI() {
        titleLabel.font = Constants.Font.subTitle
    }
    
    func configureCellData(title: String) {
        titleLabel.text = title
    }
    
}
