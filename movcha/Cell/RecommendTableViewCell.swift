//
//  RecommendTableViewCell.swift
//  movcha
//
//  Created by junehee on 6/25/24.
//

import UIKit
import SnapKit

class RecommendTableViewCell: UITableViewCell {
    
    let titleLabel = {
        let label = UILabel()
        label.font = Constants.Font.subTitle
        return label
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    static func layout() -> UICollectionViewLayout {
        let  layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureCellHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    private func configureCellLayout() {
        
    }
    
    private func configureCellUI() {
        titleLabel.text = "타이틀입니다"
    }
    
    func configureCellData() {
        
    }
}
