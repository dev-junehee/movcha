//
//  RecomendCollectionViewCell.swift
//  movcha
//
//  Created by junehee on 6/24/24.
//

import UIKit

import Kingfisher
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
        posterView.clipsToBounds = true
        posterView.layer.cornerRadius = 10
        posterView.backgroundColor = Constants.Color.Primary.pink
        posterView.contentMode = .scaleAspectFill
    }

//    func configureCellMovieData(data: MovieSimilarResults) {
//        guard let path = data.poster_path else { return }
//        let imageURL = URL(string: "\(API.URL.KMDB.img)\(path)")
//        posterView.kf.setImage(with: imageURL)
//    }
//    
//    func configureCellTVData(data: TVSimilarResults) {
//        guard let path = data.poster_path else { return }
//        let imageURL = URL(string: "\(API.URL.KMDB.img)\(path)")
//        posterView.kf.setImage(with: imageURL)
//    }
    
    func configureCellData(data: SimilarResults) {
        let imageURL = URL(string: "\(API.URL.KMDB.img)\(data.poster_path)")
        posterView.kf.setImage(with: imageURL)
    }
}
