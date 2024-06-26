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
    
    var searchCategory: Int = 0
    let posterView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellHierarchy() {
        contentView.backgroundColor = Constants.Color.Primary.pink
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
        posterView.contentMode = .scaleAspectFill
    }
    
    func configureCellData(data: SearchResults) {
        if searchCategory == 2 {
            guard let profile = data.profile_path else { return }
            posterView.kf.setImage(with: URL(string: API.URL.TMDB.img + profile))
        } else {
            guard let poster = data.poster_path else { return }
            posterView.kf.setImage(with: URL(string: API.URL.TMDB.img + poster))
        }
    }

}
