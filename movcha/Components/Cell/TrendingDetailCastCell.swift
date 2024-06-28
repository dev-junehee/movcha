//
//  TrendingDetailCastCell.swift
//  movcha
//
//  Created by junehee on 6/11/24.
//

import UIKit

import Kingfisher
import SnapKit

class TrendingDetailCastCell: BaseTableViewCell {
    
    let castImgView = UIImageView()
    
    let nameStack = UIStackView()
    let nameLabel = UILabel()
    let charactorLabel = UILabel()
    
    override func configureCellHierarchy() {
        let subViews = [castImgView, nameLabel, charactorLabel]
        subViews.forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureCellLayout() {
        castImgView.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(8)
            $0.leading.equalTo(contentView).offset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(contentView).inset(8)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(16)
            $0.trailing.equalTo(contentView).inset(8)
            $0.leading.equalTo(castImgView.snp.trailing).offset(8)
            $0.height.equalTo(20)
        }
        
        charactorLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(castImgView.snp.trailing).offset(8)
            $0.trailing.equalTo(contentView)
            $0.height.equalTo(20)
        }
    }
    
    override func configureCellUI() {
        castImgView.clipsToBounds = true
        castImgView.layer.cornerRadius = 10
        castImgView.contentMode = .scaleAspectFill
    
        nameLabel.font = .boldSystemFont(ofSize: 17)
        charactorLabel.font = Constants.Font.body
        charactorLabel.textColor = Constants.Color.Primary.darkGray
    }
    
    func configureCellData(data: Cast) {
        guard let image = data.profile_path else { return }
        let imageURL = URL(string: API.URL.TMDB.img + image)
        castImgView.kf.setImage(with: imageURL)
        
        nameLabel.text = "\(data.name) (\(data.original_name))"
        charactorLabel.text = "\(data.character)"
    }
}
