//
//  BoxOfficeTableViewCell.swift
//  movcha
//
//  Created by junehee on 6/6/24.
//

import UIKit

import SkeletonView
import SnapKit

class BoxOfficeTableViewCell: UITableViewCell {

    let rankLabel = UILabel()
    
    let mvNameAudiStack = UIStackView()
    let nameLabel = UILabel()
    let audiAccLabel = UILabel()
    
    let openDateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.isSkeletonable = true
        self.contentView.isSkeletonable = true
        
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 셀 간격 조정
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    func configureCellHierarchy() {
        let stackSubViews = [nameLabel, audiAccLabel]
        stackSubViews.forEach {
            mvNameAudiStack.addArrangedSubview($0)
        }
        
        let subViews = [rankLabel, mvNameAudiStack, openDateLabel]
        subViews.forEach {
            contentView.addSubview($0)
            $0.isSkeletonable = true
            $0.showAnimatedSkeleton()
        }
    }
    
    func configureCellLayout() {
        rankLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(50)
        }
        
        mvNameAudiStack.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(14)
            make.leading.equalTo(rankLabel.snp.trailing).offset(16)
            make.width.equalTo(150)
        }
        mvNameAudiStack.axis = .vertical
        mvNameAudiStack.alignment = .fill
        mvNameAudiStack.distribution = .fill
        mvNameAudiStack.spacing = 4
        
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
            make.width.equalTo(160)
        }

    }

    func configureCellUI() {
        contentView.backgroundColor = Color.Primary.gray6
        contentView.layer.cornerRadius = 10
        
        rankLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        rankLabel.textColor = Color.Primary.pink
        rankLabel.textAlignment = .center
        rankLabel.clipsToBounds = true
        rankLabel.layer.cornerRadius = 10
        
        mvNameAudiStack.clipsToBounds = true
        mvNameAudiStack.layer.cornerRadius = 8
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        audiAccLabel.font = .systemFont(ofSize: 12)
        
        openDateLabel.textAlignment = .right
        openDateLabel.font = .systemFont(ofSize: 12)
        openDateLabel.textColor = .gray
        openDateLabel.clipsToBounds = true
        openDateLabel.layer.cornerRadius = 8
    }
    
    func configureCellData(data: BoxOfficeList) {
        rankLabel.text = data.rank
        nameLabel.text = data.movieNm
        audiAccLabel.text = "누적관객수: \(Int(data.audiAcc)?.formatted() ?? "0")명"
        openDateLabel.text = "\(data.openDt) 개봉"
    }
}


