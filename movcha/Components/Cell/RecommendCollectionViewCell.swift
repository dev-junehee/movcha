//
//  RecomendCollectionViewCell.swift
//  movcha
//
//  Created by junehee on 6/24/24.
//

import UIKit

import Kingfisher
import SnapKit

class RecommendCollectionViewCell: BaseCollectionViewCell {
    
    let posterView = UIImageView()
    
    override func configureCellHierarchy() {
        contentView.addSubview(posterView)
    }
    
    override func configureCellLayout() {
        posterView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
    override func configureCellUI() {
        posterView.clipsToBounds = true
        posterView.layer.cornerRadius = 10
        posterView.backgroundColor = Constants.Color.Primary.pink
        posterView.contentMode = .scaleAspectFill
    }
    
    func configureCellData(data: SimilarRecommendResults) {
        let imageURL = URL(string: "\(API.URL.TMDB.img)\(data.poster_path)")
        posterView.kf.setImage(with: imageURL)
    }
}
