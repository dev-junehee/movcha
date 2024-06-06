//
//  BoxOfficeTableViewCell.swift
//  movcha
//
//  Created by junehee on 6/6/24.
//

import UIKit
import SnapKit

class BoxOfficeTableViewCell: UITableViewCell {

    let rankLabel = UILabel()
    
    let mvNameAudiStack = UIStackView()
    let nameLabel = UILabel()
    let audiAccLabel = UILabel()
    
    let openDateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    func configureCellHierarchy() {
        let stackSubViews = [nameLabel, audiAccLabel]
        stackSubViews.forEach {
            mvNameAudiStack.addArrangedSubview($0)
        }
        
        let subViews = [rankLabel, mvNameAudiStack, openDateLabel]
        subViews.forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureCellLayout() {
        rankLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(10)
            make.size.equalTo(40)
            make.centerY.equalTo(contentView)
        }
        
        mvNameAudiStack.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(14)
            make.leading.equalTo(rankLabel.snp.trailing).offset(16)
        }
        mvNameAudiStack.axis = .vertical
        mvNameAudiStack.alignment = .fill
        mvNameAudiStack.distribution = .fill
        mvNameAudiStack.spacing = 8
        
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
        }

        audiAccLabel.snp.makeConstraints { make in
            make.height.equalTo(12)
        }
        
        openDateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(8)
            make.bottom.equalTo(contentView).inset(4)
            make.leading.equalTo(mvNameAudiStack.snp.trailing).offset(16)
            make.width.equalTo(100)
        }

    }

    func configureCellUI() {
        contentView.backgroundColor = Color.Primary.gray
        contentView.layer.cornerRadius = 10
        
        rankLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        rankLabel.textColor = Color.Primary.pink
        rankLabel.textAlignment = .center
        rankLabel.layer.cornerRadius = rankLabel.frame.width / 2
        rankLabel.layer.borderColor = Color.Primary.pink.cgColor
    
        nameLabel.font = .systemFont(ofSize: 22, weight: .heavy)
//        nameLabel.backgroundColor = .blue
        
        audiAccLabel.font = .systemFont(ofSize: 12)
//        audiAccLabel.backgroundColor = .yellow
        
        openDateLabel.textAlignment = .right
        openDateLabel.font = .systemFont(ofSize: 12)
        openDateLabel.textColor = .gray
        
        // 임시 데이터
        rankLabel.text = "1"
        nameLabel.text = "서울의 봄"
        audiAccLabel.text = "누적관객수: 126,456,789"
        openDateLabel.text = "00.00.00 개봉"
    }
    

}


