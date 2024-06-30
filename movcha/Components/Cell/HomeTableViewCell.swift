//
//  HomeMainTableViewCell.swift
//  movcha
//
//  Created by junehee on 6/29/24.
//

import UIKit
import SnapKit

class HomeTableViewCell: BaseTableViewCell {
    
    var isMain = true
    
    let titleLabel = UILabel()
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: layout()
    )
    
    func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func configureCellHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configureCellLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(8)
            $0.horizontalEdges.equalTo(contentView).inset(20)
            $0.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    
    override func configureCellUI() {
//        collectionView.backgroundColor = .darkGray
    }
    
    func configureCellData(data: String) {
        titleLabel.text = data
    }
    
}
