//
//  TrendingDetailCastCell.swift
//  movcha
//
//  Created by junehee on 6/11/24.
//

import UIKit

import Kingfisher
import SnapKit

class TrendingDetailCastCell: UITableViewCell {
    
    let castImgView = UIImageView()
    
    let nameStack = UIStackView()
    let nameLabel = UILabel()
    let charactorLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(charactorLabel)
        
        contentView.addSubview(castImgView)
        contentView.addSubview(nameStack)
    }
    
    func configureLayout() {
        castImgView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView).inset(8)
            make.leading.equalTo(contentView).inset(16)
            make.width.equalTo(60)
        }
        
        nameStack.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView).inset(8)
            make.leading.equalTo(castImgView.snp.trailing).offset(16)
            make.trailing.equalTo(contentView).inset(16)
        }
        nameStack.axis = .vertical
        
        nameLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(nameStack)
            make.height.equalTo(20)
        }
        
        charactorLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(nameStack)
            make.height.equalTo(20)
        }
    }
    
    func configureUI() {
        castImgView.clipsToBounds = true
        castImgView.layer.cornerRadius = 10
        castImgView.contentMode = .scaleAspectFit
    }
    
    func configureCellData(data: Cast) {
        guard let image = data.profile_path else { return }
        let imageURL = URL(string: API.URL.TMDB.img + image)
        castImgView.kf.setImage(with: imageURL)
        
        nameLabel.text = "\(data.name) (\(data.original_name)"
        charactorLabel.text = "\(data.character)"
    }
}
