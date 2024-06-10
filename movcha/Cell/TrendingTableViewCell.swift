//
//  TrendingTableViewCell.swift
//  movcha
//
//  Created by junehee on 6/10/24.
//

import UIKit
import SnapKit

class TrendingTableViewCell: UITableViewCell {
    // 카드 그림자
    let cardBackView = UIView()
    
    // 스택1: 개봉일, 장르
    let dateGenreStack = UIStackView()
    let openDateLabel = UILabel()
    let genreLabel = UILabel()

    // 카드
    let cardView = UIView()
    let cardImg = UIImageView()
    
    // 스택2: 평점
    let voteStack = UIStackView()
    let voteLabel = UILabel()
    let voteAverage = UILabel()
    
    let titleOverviewStack = UIStackView()
    let titleLabel = UILabel()
    let overviewLabel = UILabel()
    
    // 스택3: 자세 보기
    let detailStack = UIStackView()
    let detailLabel = UILabel()
    let detailImgView = UIImageView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 임시 확인
//        contentView.backgroundColor = .blue
        
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 테이블 뷰 셀 사이의 간격
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }

    func configureCellHierarchy() {
        let dateGenreViews = [openDateLabel, genreLabel]
        dateGenreViews.forEach {
            dateGenreStack.addArrangedSubview($0)
        }
        
        let voteViews = [voteLabel, voteAverage]
        voteViews.forEach {
            voteStack.addArrangedSubview($0)
        }
        
        let titleOverviews = [titleLabel, overviewLabel]
        titleOverviews.forEach {
            titleOverviewStack.addArrangedSubview($0)
        }
        
        let detailViews: [Any] = [detailLabel, detailImgView]
        detailViews.forEach {
            detailStack.addArrangedSubview($0 as! UIView)
        }
        
        let cardViews = [cardView, cardImg, voteStack, titleOverviewStack, detailStack]
        cardViews.forEach {
            cardBackView.addSubview($0)
        }
        
        contentView.addSubview(dateGenreStack)
        contentView.addSubview(cardBackView)
    }
    
    func configureCellLayout() {
        dateGenreStack.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(40)
        }
        dateGenreStack.axis = .vertical
        
        cardBackView.snp.makeConstraints { make in
            make.top.equalTo(dateGenreStack.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView).inset(16)
            make.height.equalTo(cardBackView.snp.width)
        }

        cardView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(cardBackView)
        }
        
        cardImg.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(cardView)
            make.height.equalTo(220)
        }
        
        voteStack.snp.makeConstraints { make in
            make.leading.equalTo(cardImg.snp.leading).inset(24)
            make.bottom.equalTo(cardImg.snp.bottom).inset(24)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        voteStack.axis = .horizontal
        voteStack.distribution = .fillEqually
        
        titleOverviewStack.snp.makeConstraints { make in
            make.top.equalTo(cardImg.snp.bottom)
            make.horizontalEdges.equalTo(cardView).inset(24)
            make.height.equalTo(70)
        }
        titleOverviewStack.axis = .vertical

        detailStack.snp.makeConstraints { make in
            make.top.equalTo(titleOverviewStack.snp.bottom)
            make.horizontalEdges.equalTo(cardView).inset(24)
            make.height.equalTo(40)
            make.bottom.equalTo(cardView).inset(4)
        }
        detailStack.axis = .horizontal
        detailStack.distribution = .equalSpacing
        
        detailImgView.snp.makeConstraints { make in
            make.height.equalTo(10)
        }
        
    }
    
    func configureCellUI() {
        // 임시 확인
        openDateLabel.textColor = .lightGray
        genreLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        
        cardBackView.backgroundColor = .white
        cardBackView.layer.cornerRadius = 10
        cardBackView.layer.shadowColor = UIColor.black.cgColor
        cardBackView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardBackView.layer.shadowRadius = 10
        cardBackView.layer.shadowOpacity = 0.4
        
        cardView.backgroundColor = .white
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 10
        
        cardImg.backgroundColor = .blue
        cardImg.clipsToBounds = true
        cardImg.layer.cornerRadius = 10
        cardImg.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        voteStack.backgroundColor = .white
        voteLabel.backgroundColor = Color.Primary.pink
        voteLabel.textAlignment = .center
        voteLabel.textColor = .white
        voteAverage.textAlignment = .center
        
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        overviewLabel.font = .systemFont(ofSize: 14)

        detailStack.clipsToBounds = true
        detailStack.layer.cornerRadius = 10
        detailStack.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        detailImgView.contentMode = .scaleAspectFit
        detailImgView.tintColor = Color.Primary.pink
    }
    
    func configureCellData() {
        openDateLabel.text = "2022/12/06"
        genreLabel.text = "#Mystery"
        
        voteLabel.text = "평점"
        voteAverage.text = "3.3"
        
        titleLabel.text = "영화이름"
        overviewLabel.text = "영화설명이들어갈자리 영화설명이들어갈자리"
        
        detailLabel.text = "자세히 보기"
        detailImgView.image = UIImage(systemName: "chevron.right")
    }
}
