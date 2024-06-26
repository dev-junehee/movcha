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
        configureCellUI()
        configureCellLayout()
    }
    
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
        let backdrop = data.backdrop_path
        let poster = data.poster_path
        let profile = data.profile_path
        
        let backdropURL = URL(string: "\(API.URL.TMDB.img)\(backdrop)")
        let posterURL = URL(string: "\(API.URL.TMDB.img)\(poster)")
        let profileURL = URL(string: "\(API.URL.TMDB.img)\(profile)")
        
        if searchCategory == 2 {
            posterView.kf.setImage(with: profileURL)
        } else {
            posterView.kf.setImage(with: posterURL ?? backdropURL)
        }
    }
    
}
