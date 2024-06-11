//
//  SearchCollectionViewCell.swift
//  movcha
//
//  Created by junehee on 6/12/24.
//

import UIKit

import Kingfisher
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    let posterView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCellHierarchy()
        configureCellUI()
        configureCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellHierarchy() {
        contentView.backgroundColor = Color.Primary.pink
        contentView.addSubview(posterView)
    }
    
    func configureCellLayout() {
        posterView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    func configureCellUI() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.contentMode = .scaleAspectFill
    }
    
    func configureCellData(data: TVResults) {
        let IMG_URL = URL(string: "\(API.URL.kmdbImg)\(data.poster_path)")
        posterView.kf.setImage(with: IMG_URL)
    }
    
}
