//
//  TrendingDetailCastCell.swift
//  movcha
//
//  Created by junehee on 6/11/24.
//

import UIKit
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
    }
    
    func configureUI() {
        castImgView.backgroundColor = .blue
        castImgView.layer.cornerRadius = 10
        
        nameStack.backgroundColor = .yellow
        
        nameLabel.backgroundColor = .red
        charactorLabel.backgroundColor = .orange
    }
}
